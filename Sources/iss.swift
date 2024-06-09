//
//  NC.swift
//
//
//  Created by Mark Strijdom on 29/05/2024.
//

import ANSITerminal
import ArgumentParser
import CoreLocation
import Figlet
import Foundation
import MapKit
import SGPKit
import SwiftSoup

@available(macOS 12, *)
@main
struct Iss: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "A cli which lets you know the current position of the International Space Station, as well as who is on board and other interesting random trivia", version: "1.0.0")
    
    @Argument(help: "Choose what ISS information you are looking for (location, speed, altitude, personnel, fact or docked)") var request: String
    
    mutating func validate() throws {
        guard request == "location" || request == "speed" || request == "altitude" || request == "personnel" || request == "fact" || request == "docked" else {
            throw ValidationError("Please choose a valid request (location, speed, altitude, personnel, fact or docked)")
        }
    }
    
    mutating func run() throws {
        if request == "location" {
            showLocation()
        } else if request == "speed" {
            getSpeed()
        } else if request == "altitude" {
            getAltitude()
        } else if request == "personnel" {
            getPersonnel()
        } else if request == "fact" {
            getFact()
        } else if request == "docked" {
            getDocked()
        }
    }
}

func HTMLParse(from: String) -> String {
    var contents = ""
    
    if let url = URL(string: from) {
        do {
            contents = try String(contentsOf: url)
        } catch {
            print("contents could not be loaded")
        }
    } else {
        print("Bad URL")
    }
    
    do {
        let _: Document = try SwiftSoup.parse(contents)
    } catch {
        print("HTML not found")
    }
    
    return contents
}

func getTLE() -> [String] {
    let rawString = HTMLParse(from: "http://celestrak.org/NORAD/elements/gp.php?CATNR=25544&FORMAT=TLE")
    let newArray = rawString.components(separatedBy: "\r\n")
    return newArray
}

@available(macOS 12, *)
func fetchLocation() -> CLLocation {
    let dataArray = getTLE()
    let title = dataArray[0]
    let firstLine = dataArray[1]
    let secondLine = dataArray[2]
    
    let tle = TLE(title: title, firstLine: firstLine, secondLine: secondLine)
    let interpreter = TLEInterpreter()
    
    let data: SatelliteData = interpreter.satelliteData(from: tle, date: .now)
    
    return CLLocation(latitude: data.latitude, longitude: data.longitude)
}

@available(macOS 12, *)
func showLocation() {
    let location = fetchLocation()
    let lat = location.coordinate.latitude
    let long = location.coordinate.longitude
    
    print("i".inverse.lightGreen.bold, terminator: "")
    print(" ".inverse.green.bold, terminator: " ")
    print("The ISS is currently at latitude: \(lat), longitude: \(long).".lightGreen.bold)
}

@available(macOS 12, *)
func getSpeed() {
    let dataArray = getTLE()
    let title = dataArray[0]
    let firstLine = dataArray[1]
    let secondLine = dataArray[2]
    
    let tle = TLE(title: title, firstLine: firstLine, secondLine: secondLine)
    let interpreter = TLEInterpreter()
    
    let data: SatelliteData = interpreter.satelliteData(from: tle, date: .now)
    
    let formattedSpeed = String(format: "%.2f", data.speed)
    print("i".inverse.lightGreen.bold, terminator: "")
    print(" ".inverse.green.bold, terminator: " ")
    print("The ISS is currently travelling at a speed of \(formattedSpeed) km/h, or \((Float(formattedSpeed) ?? 0) * 0.0002777778) km/s.".lightGreen.bold)
}

@available(macOS 12, *)
func getAltitude() {
    let dataArray = getTLE()
    let title = dataArray[0]
    let firstLine = dataArray[1]
    let secondLine = dataArray[2]
    
    let tle = TLE(title: title, firstLine: firstLine, secondLine: secondLine)
    let interpreter = TLEInterpreter()
    
    let data: SatelliteData = interpreter.satelliteData(from: tle, date: .now)
    
    let formattedAltitude = String(format: "%.2f", data.altitude)
    print("i".inverse.lightGreen.bold, terminator: "")
    print(" ".inverse.green.bold, terminator: " ")
    print("The ISS is currently orbiting at an altitude of \(formattedAltitude) km".lightGreen.bold)
}

func decode<T: Codable>(_ file: String) -> T {
    guard let data = file.data(using: .utf8) else {
        fatalError("Failed to load \(file) from bundle.")
    }

    let decoder = JSONDecoder()

    do {
        return try decoder.decode(T.self, from: data)
    } catch DecodingError.keyNotFound(let key, let context) {
        fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' – \(context.debugDescription)")
    } catch DecodingError.typeMismatch(_, let context) {
        fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
    } catch DecodingError.valueNotFound(let type, let context) {
        fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
    } catch DecodingError.dataCorrupted(_) {
        fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON.")
    } catch {
        fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
    }
}

func getFact() {
    let facts: [Fact] = decode(facts)
    let fact = facts.randomElement()
    print("i".inverse.lightGreen.bold, terminator: "")
    print(" ".inverse.green.bold, terminator: " ")
    print(fact?.description.lightGreen.bold ?? "ISS facts cannot be accessed at this time")
}

func getPersonnel() {
    print("i".inverse.lightGreen.bold, terminator: "")
    print(" ".inverse.green.bold, terminator: " ")
    print("The following personnel are currently aboard the ISS:".lightGreen.bold)
    do {
        let html = HTMLParse(from: "https://en.wikipedia.org/wiki/List_of_crew_of_the_International_Space_Station")
        let doc: Document = try SwiftSoup.parse(html)
        
        guard let body = doc.body() else {
            return
        }
        
        let astronauts: Elements = try body.getElementsByTag("b")
        for astronaut in astronauts {
            if try astronaut.text().count > 10 && !astronaut.text().hasPrefix("list") {
                print(try astronaut.text().lightGreen.bold)
            }
        }
        
    } catch Exception.Error(let type, let message) {
        print(message)
        print(type)
        
    } catch {
        print("error")
    }
}

func getDocked() {
    print("i".inverse.lightGreen.bold, terminator: "")
    print(" ".inverse.green.bold, terminator: " ")
    print("The following vessels are currently docked with the ISS:".lightGreen.bold)
    do {
        let html = HTMLParse(from: "https://en.wikipedia.org/wiki/International_Space_Station")
        let doc: Document = try SwiftSoup.parse(html)

        guard let body = doc.body() else {
            return
        }

        let docked: Elements = try body.getElementsByTag("#Currently_docked/berthed")
        for vessel in docked {
            print(try vessel.text())
        }
    } catch Exception.Error(let type, let message) {
        print(message)
        print(type)

    } catch {
        print("error")
    }
    
}


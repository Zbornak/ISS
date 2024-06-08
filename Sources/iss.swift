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
    
    @Argument(help: "Choose what ISS information you are looking for.") var request: String
    
    mutating func run() throws {
        if request == "location" {
            getCoords()
        } else if request == "speed" {
            getSpeed()
        } else if request == "altitude" {
            getAltitude()
        } else if request == "personnel" {
            getPersonnel()
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
func getCoords() {
    let dataArray = getTLE()
    let title = dataArray[0]
    let firstLine = dataArray[1]
    let secondLine = dataArray[2]
    
    let tle = TLE(title: title, firstLine: firstLine, secondLine: secondLine)
    let interpreter = TLEInterpreter()
    
    let data: SatelliteData = interpreter.satelliteData(from: tle, date: .now)
    
    print("i".inverse.lightGreen.bold, terminator: " ")
    print("The ISS is at latitude: \(data.latitude), longitude: \(data.longitude).".lightGreen.bold)
    lookUpCurrentLocation(lat: data.latitude, long: data.longitude)
}

func lookUpCurrentLocation(lat: Double, long: Double) {
    var firstLocation: CLPlacemark?
    let lastLocation = CLLocation(latitude: lat, longitude: long)
    let geocoder = CLGeocoder()
        
    geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placemarks, error) in
        if error == nil {
            firstLocation = placemarks?[0]
        } else {
            return
        }
    })
    
    print("i".inverse.lightGreen.bold, terminator: " ")
    print("It is currently over \(firstLocation?.locality ?? "error"), \(firstLocation?.country ?? "error").".lightGreen.bold)
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
    print("i".inverse.lightGreen.bold, terminator: " ")
    print("The ISS is travelling at a speed of \(formattedSpeed) km/h, or \((Float(formattedSpeed) ?? 0) * 0.0002777778) km/s.".lightGreen.bold)
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
    print("i".inverse.lightGreen.bold, terminator: " ")
    print("The ISS is travelling at an altitude of \(formattedAltitude) km".lightGreen.bold)
}

func getRandomISSFact() {
    
}

func getPersonnel() {
    print("i".inverse.lightGreen.bold, terminator: " ")
    print("The following personnel are currently aboard the ISS:".lightGreen.bold)
    do {
        let html = HTMLParse(from: "https://en.wikipedia.org/wiki/List_of_crew_of_the_International_Space_Station")
        let doc: Document = try SwiftSoup.parse(html)
        
        guard let body = doc.body() else {
            return
        }
        
        let links: Elements = try body.getElementsByTag("b")
        for link in links {
            if try link.text().count > 10 && !link.text().hasPrefix("list") {
                print(try link.text().lightGreen.bold)
            }
        }
        
    } catch Exception.Error(let type, let message) {
        print(message)
        print(type)
        
    } catch {
        print("error")
    }
}


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
    
    mutating func run() throws {
        getCoords()
        getSpeed()
        getAltitude()
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
    
    let latitude = data.latitude
    let longitude = data.longitude
    let locality = getLocality(lat: data.latitude, long: data.longitude)
    
    print("The ISS is at latitude: \(data.latitude), longitude: \(data.longitude).".lightGreen.bold)
    print(locality)
}

func getLocality(lat: Double, long: Double) -> String {
    let currentCity = ""
    let currentCountry = ""
    let geoCoder = CLGeocoder()
    let location = CLLocation(latitude: lat, longitude: long)
    
    geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
        guard let placemark = placemarks?.first else {
            return
        }
        
        if let city = placemark.locality {
            let currentCity = city
        }
        
        if let country = placemark.country {
            let currentCountry = country
        }
    })
    
    return "It is currently over: \(currentCity), \(currentCountry).".lightGreen.bold
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
    print("The ISS is travelling at an altitude of \(formattedAltitude) km".lightGreen.bold)
}


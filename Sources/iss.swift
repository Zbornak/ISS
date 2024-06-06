//
//  NC.swift
//
//
//  Created by Mark Strijdom on 29/05/2024.
//

import ArgumentParser
import Figlet
import Foundation
import SGPKit
import SwiftSoup

@available(macOS 12, *)
@main
struct Iss: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "A cli which lets you know the current position of the International Space Station, as well as who is on board and other interesting random trivia", version: "1.0.0")
    
    mutating func run() throws {
        getCoords()
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
    
    // print(data.altitude)
    // print(data.speed)
    print("The ISS is currently at latitude: \(data.latitude), longitude: \(data.longitude)")
}

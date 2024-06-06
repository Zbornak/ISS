//
//  NC.swift
//
//
//  Created by Mark Strijdom on 29/05/2024.
//

import ArgumentParser
import Figlet
import Foundation

@main
struct Iss: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "A cli which lets you know the current position of the International Space Station, as well as who is on board and other interesting random trivia", version: "1.0.0")
    
    mutating func run() throws {
        print("Hello iss!")
    }
}

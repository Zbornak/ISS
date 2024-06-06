//
//  HTMLParser.swift
//
//
//  Created by Mark Strijdom on 06/06/2024.
//

import Foundation
import SwiftSoup

class HTMLParser {
    func parse(from: String) {
        var contents = ""
        
        if let url = URL(string: from) {
            do {
                contents = try String(contentsOf: url)
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
        
        do {
            let document: Document = try SwiftSoup.parse(contents)
            print(document)
        } catch {
            print("HTML not found")
        }
    }
    
}

//
//  String.swift
//  NailBuddy
//
//  Created by Mike Collier on 11/8/21.
//

import Foundation

extension String {
    static func randomString(numberOfCharacters: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyz"
        var string = ""
        while string.count < numberOfCharacters {
            guard let c = characters.randomElement() else { continue }
            string += String(c)
        }
        
        return string
    }
}

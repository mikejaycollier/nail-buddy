//
//  ClientExtension.swift
//  NailBuddy
//
//  Created by Mike Collier on 1/15/22.
//

import Foundation

extension Client {
    var fullName: String {
        return (firstName ?? "") + " " + (lastName ?? "")
    }
}

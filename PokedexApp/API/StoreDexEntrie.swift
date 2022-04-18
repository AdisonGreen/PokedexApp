//
//  StoreDexEntrie.swift
//  PokedexApp
//
//  Created by Adison Green on 4/18/22.
//

import Foundation
import UIKit

struct StoreDexEntire: Codable {
    var flavor_text_entries: [FlavorTextEntires]
}

struct FlavorTextEntires: Codable {
    var flavor_text: String
    var language: Language
    var version: Version
}

struct Language: Codable {
    var name: String
}

struct Version: Codable {
    var name: String
}

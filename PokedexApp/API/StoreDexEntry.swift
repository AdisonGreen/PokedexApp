//
//  StoreDexEntrie.swift
//  PokedexApp
//
//  Created by Adison Green on 4/18/22.
//

import Foundation
import UIKit

struct StoreDexEntry: Codable {
    var flavor_text_entries: [FlavorTextEntries]
}

struct FlavorTextEntries: Codable {
    var flavor_text: String
    var language: Language
    var version: Version
}

struct Language: Codable {
    var name: String
    var isEnglish: Bool {
        return name == "en"
    }
}

struct Version: Codable {
    var name: String
    
    var isGenOne: Bool {
        return name == "red" || name == "blue" || name == "yellow" || name == "green"
    }
}

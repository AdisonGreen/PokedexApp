//
//  StoreAbilityDescriptions.swift
//  PokedexApp
//
//  Created by Adison Green on 4/28/22.
//

import Foundation
import UIKit

struct StoreAbilityDescriptions: Codable {
    var effect_entries: [EffectEntries]
    var flavor_text_entries: [FlavorTextEntriesForAbilities]
}

struct FlavorTextEntriesForAbilities: Codable {
    var flavor_text: String
    var language: LanguageForFlavorText
}

struct LanguageForFlavorText: Codable {
    var name: String
    var isEnglish: Bool {
        return name == "en"
    }
}

struct EffectEntries: Codable {
    var effect: String
    var language: LanguageForEffectOfAbilities
}

struct LanguageForEffectOfAbilities: Codable {
    var name: String
}

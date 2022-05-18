//
//  StorePokemonForms.swift
//  PokedexApp
//
//  Created by Adison Green on 5/17/22.
//

import Foundation
import UIKit

struct StorePokemonForms: Codable {
    var varieties: [PokemonVarieties]
}

struct PokemonVarieties: Codable {
    var isDefault: Bool
    var pokemon: PokemonVarietiesNames
    
    enum CodingKeys: String, CodingKey {
        case isDefault = "is-default"
        case pokemon = "pokemon"
    }
}

struct PokemonVarietiesNames: Codable {
    var name: String
}

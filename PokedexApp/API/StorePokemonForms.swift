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
    var is_default: Bool
    var pokemon: PokemonVarietiesNames
}

struct PokemonVarietiesNames: Codable {
    var name: String
}

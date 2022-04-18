//
//  StorePokemon.swift
//  PokedexApp
//
//  Created by Adison Green on 4/12/22.
//

import Foundation
import UIKit

struct StorePokemon: Codable {
    var name: String
    var types: [PokemonTypes]
}

struct PokemonTypes: Codable {
    var type: Types
}

struct Types: Codable {
    var name: String
}

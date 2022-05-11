//
//  StorePokemonSpecies.swift
//  PokedexApp
//
//  Created by Adison Green on 5/10/22.
//

import Foundation
import UIKit

struct StorePokemonSpecies: Codable {
    var varieties: [Varieties]
}

struct Varieties: Codable {
    var pokemon: PokemonFromVarieties
}

struct PokemonFromVarieties: Codable {
    var url: String
}

//
//  StorePokemon.swift
//  PokedexApp
//
//  Created by Adison Green on 3/11/22.
//

import Foundation
import UIKit

struct StoreAllPokemon: Codable {
    var name: String
    var url: URL
}

struct SearchResponse: Codable {
    let results: [StoreAllPokemon]
}

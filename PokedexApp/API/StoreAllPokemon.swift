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
    var url: String
    var pokedexNumber: Int {
        let pokemonNum = url.replacingOccurrences(of: "/", with: "")
        let someNum = pokemonNum.replacingOccurrences(of: "https:pokeapi.coapiv2pokemon-species", with: "")
        return Int(someNum)!
    }
}

struct SearchResponse: Codable {
    let results: [StoreAllPokemon]
}

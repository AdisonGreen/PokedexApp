//
//  StorePokemon.swift
//  PokedexApp
//
//  Created by Adison Green on 4/4/22.
//

import Foundation
import UIKit

struct StorePokemonSprite: Codable {
    var sprites: Sprites
}

struct Sprites: Codable {
    var other: Other
}

struct Other: Codable {
    var officialArtwork: Artwork
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct Artwork: Codable {
    var front_default: String
}

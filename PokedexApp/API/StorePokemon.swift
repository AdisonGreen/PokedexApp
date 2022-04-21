//
//  StorePokemon.swift
//  PokedexApp
//
//  Created by Adison Green on 4/12/22.
//

import Foundation
import UIKit

struct StorePokemon: Decodable {
    var name: String
    var types: [PokemonType]
    var abilities: [Abilities]
}

struct Abilities: Decodable {
    var ability: AbilitiyName
    var is_hidden: Bool
}

struct AbilitiyName: Decodable {
    var name: String
    var url: String
}

enum PokemonError: Error {
    case decodeFail
}

enum PokemonType: String, Decodable {
    case grass
    case poison
    case fire
    case water
    case flying
    case dragon
    case fairy
    case dark
    case ground
    case rock
    case normal
    case bug
    case ice
    case steel
    case ghost
    case fighting
    case psychic
    case electric
    case unknown
    
    enum CodingKeys: CodingKey {
        case type
    }
    
    enum MoreInfo: CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let moreInfo = try values.nestedContainer(keyedBy: MoreInfo.self, forKey: .type)
        let typeName = try moreInfo.decode(String.self, forKey: .name)
        self = Self.init(rawValue: typeName) ?? .unknown
    }
    
    var color: UIColor {
        switch self {
        case .grass: return .grassGreen
        case .poison: return .poisonPurple
        case .fire: return .fireRed
        case .flying: return .flyingBlue
        case .bug: return .bugGreen
        case .normal: return .normalGray
        case .electric: return .electricYellow
        case .rock: return .rockBrown
        case .ground: return .groundBrown
        case .water: return .waterBlue
        case .fairy: return .fairyPink
        case .fighting: return .fightingOrange
        case .psychic: return .psychicPink
        case .ice: return .iceBlue
        case .dragon: return .dragonBlue
        case .steel: return .steelGray
        case .ghost: return .ghostPurple
        case .dark: return .darkBlack
        case .unknown: return .gray
        }
    }
}

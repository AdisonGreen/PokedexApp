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
        case .grass: return .grassTypeColor
        case .poison: return .poisonTypeColor
        case .fire: return .fireTypeColor
        case .flying: return .flyingTypeColor
        case .bug: return .bugTypeColor
        case .normal: return .normalTypeColor
        case .electric: return .electricTypeColor
        case .rock: return .rockTypeColor
        case .ground: return .groundTypeColor
        case .water: return .waterTypeColor
        case .fairy: return .fairyTypeColor
        case .fighting: return .fireTypeColor
        case .psychic: return .psychicTypeColor
        case .ice: return .iceTypeColor
        case .dragon: return .dragonTypeColor
        case .steel: return .steelTypeColor
        case .ghost: return .ghostTypeColor
        case .dark: return .darkTypeColor
        case .unknown: return .gray
        }
    }
}

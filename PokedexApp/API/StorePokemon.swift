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
}

//struct PokemonTypes: Codable {
//    var type: Types
//}
//
//struct Types: Codable {
//    var name: String
//}

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
            case .grass: return UIColor(cgColor: CGColor(red: 0.3, green: 0.9, blue: 0.3, alpha: 1.0))
            case .poison: return UIColor(cgColor: CGColor(red: 0.5, green: 0.1, blue: 0.5, alpha: 1.0))
            case .fire: return UIColor(cgColor: CGColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0))
            case .flying: return UIColor(cgColor: CGColor(red: 0.1, green: 0.7, blue: 0.8, alpha: 1.0))
            case .bug: return UIColor(cgColor: CGColor(red: 0.2, green: 0.4, blue: 0.1, alpha: 1.0))
            case .normal: return UIColor(cgColor: CGColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0))
            case .electric: return UIColor(cgColor: CGColor(red: 0.9, green: 0.9, blue: 0.1, alpha: 1.0))
            case .rock: return UIColor(cgColor: CGColor(red: 0.5, green: 0.4, blue: 0.2, alpha: 1.0))
            case .ground: return UIColor(cgColor: CGColor(red: 0.7, green: 0.5, blue: 0.1, alpha: 1.0))
            case .water: return UIColor(cgColor: CGColor(red: 0.1, green: 0.5, blue: 0.9, alpha: 1.0))
            case .fairy: return UIColor(cgColor: CGColor(red: 0.9, green: 0.5, blue: 0.6, alpha: 1.0))
            case .fighting: return UIColor(cgColor: CGColor(red: 0.9, green: 0.4, blue: 0.1, alpha: 1.0))
            case .psychic: return UIColor(cgColor: CGColor(red: 0.9, green: 0.3, blue: 0.4, alpha: 1.0))
            case .ice: return UIColor(cgColor: CGColor(red: 0.3, green: 0.7, blue: 0.9, alpha: 1.0))
            case .dragon: return UIColor(cgColor: CGColor(red: 0.3, green: 0.3, blue: 0.9, alpha: 1.0))
            case .steel: return UIColor(cgColor: CGColor(red: 0.8, green: 0.8, blue: 0.9, alpha: 1.0))
            case .ghost: return UIColor(cgColor: CGColor(red: 0.6, green: 0.4, blue: 0.6, alpha: 1.0))
            case .dark: return UIColor(cgColor: CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
            case .unknown: return UIColor.gray
        }
    }
}

//
//  StoreStats.swift
//  PokedexApp
//
//  Created by Adison Green on 5/3/22.
//

import Foundation
import UIKit

struct StoreStats: Decodable {
    var stats: [Stats]
}

struct Stats: Decodable {
    var base_stat: Int
    var stat: StatDescription
}

struct StatDescription: Decodable {
    var name: String
}

//
//  PokemonStats.swift
//  PokedexApp
//
//  Created by Adison Green on 5/3/22.
//

import Foundation
import UIKit

struct PokemonStats {
    var pokedexNumber: Int
    
    func fetchItems(completion: @escaping (Result<StoreStats, Error>) -> Void) {
        let urlComponents = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/\(pokedexNumber)")!
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try
                    decoder.decode(StoreStats.self, from: data)
                    completion(.success(searchResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

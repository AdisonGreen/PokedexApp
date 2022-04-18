//
//  File.swift
//  PokedexApp
//
//  Created by Adison Green on 3/11/22.
//

import Foundation
import UIKit

struct PokemonInfo {
    func fetchItems(completion: @escaping (Result<[StoreAllPokemon], Error>) -> Void) {
        let urlComponents = URLComponents(string: "https://pokeapi.co/api/v2/pokemon-species?limit=898")!
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try
                    decoder.decode(SearchResponse.self, from: data)
                    completion(.success(searchResponse.results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Adison Green on 4/14/22.
//

import Foundation
import UIKit

struct Pokemon {
    var pokedexNumber: Int
    
    func fetchItems(completion: @escaping (Result<StorePokemon, Error>) -> Void) {
        let urlComponents = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/\(pokedexNumber)")!
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try
                    decoder.decode(StorePokemon.self, from: data)
                    completion(.success(searchResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

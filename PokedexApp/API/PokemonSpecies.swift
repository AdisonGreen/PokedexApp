//
//  PokemonSpecies.swift
//  PokedexApp
//
//  Created by Adison Green on 5/10/22.
//

import Foundation
import UIKit

//struct PokemonSpecies: Codable {
//    func fetchItems(urlFromPokemon: String, completion: @escaping (Result<StorePokemonSpecies, Error>) -> Void) {
//        let urlComponents = URLComponents(string: "\(urlFromPokemon)")!
//        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//            } else if let data = data {
//                do {
//                    let decoder = JSONDecoder()
//                    let searchResponse = try
//                    decoder.decode(StorePokemonSpecies.self, from: data)
//                    completion(.success(searchResponse))
//                } catch {
//                    completion(.failure(error))
//                }
//            }
//        }
//        task.resume()
//    }
//}

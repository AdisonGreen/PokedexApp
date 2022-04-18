//
//  FetchPokemon.swift
//  PokedexApp
//
//  Created by Adison Green on 4/4/22.
//

import Foundation
import UIKit

struct PokemonSprites {
    var pokedexNumber: Int
    
    func fetchItems(completion: @escaping (Result<UIImage, Error>) -> Void) {
        let urlComponents = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/\(pokedexNumber)/")!
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try
                    decoder.decode(StorePokemonSprite.self, from: data)
                    let pokemonTask = URLSession.shared.dataTask(with: URL(string: searchResponse.sprites.other.officialArtwork.front_default)!) { data, response, error in
                        if let error = error {
                            print(error)
                            completion(.failure(error))
                        } else if let data = data, let image = UIImage(data: data) {
                            completion(.success(image))
                        }
                    }
                    pokemonTask.resume()
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

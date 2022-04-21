//
//  DexEntries.swift
//  PokedexApp
//
//  Created by Adison Green on 4/18/22.
//

import Foundation
import UIKit

struct DexEntries {
    var pokedexNumber: Int
    
    func fetchItems(compeltion: @escaping (Result<StoreDexEntry, Error>) -> Void) {
        let urlComponents = URLComponents(string: "https://pokeapi.co/api/v2/pokemon-species/\(pokedexNumber)/")!
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            if let error = error {
                compeltion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try
                    decoder.decode(StoreDexEntry.self, from: data)
                    compeltion(.success(searchResponse))
                } catch {
                    compeltion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

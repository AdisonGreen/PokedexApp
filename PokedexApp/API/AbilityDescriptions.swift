//
//  AbilityDescriptions.swift
//  PokedexApp
//
//  Created by Adison Green on 4/28/22.
//

import Foundation
import UIKit

struct AbilityDescriptions {
    func fetchItems(url: String, completion: @escaping (Result<StoreAbilityDescriptions, Error>) -> Void) {
        let urlComponents = URLComponents(string: url)!
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try
                    decoder.decode(StoreAbilityDescriptions.self, from: data)
                    completion(.success(searchResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

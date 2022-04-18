//
//  StringExtension.swift
//  PokedexApp
//
//  Created by Adison Green on 3/11/22.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitilizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

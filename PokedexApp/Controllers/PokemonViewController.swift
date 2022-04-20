//
//  PokemonViewController.swift
//  PokedexApp
//
//  Created by Adison Green on 3/11/22.
//

import UIKit

class PokemonViewController: UIViewController {
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokedexNum: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var firstType: UILabel!
    @IBOutlet weak var secondType: UILabel!
    @IBOutlet weak var dexDescriptions: UILabel!
    
    var pokedexNumber: Int
    
    init?(coder: NSCoder, pokedexNumber: Int) {
        self.pokedexNumber = pokedexNumber
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        self.pokedexNumber = 1
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemon()
        fetchPokemonImage()
        fetchDexEntires()
    }
    
    func fetchPokemonImage() {
        let pokemonSpriteInstance = PokemonSprites(pokedexNumber: pokedexNumber)
        pokemonSpriteInstance.fetchItems { result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    self.pokemonImage.image = info
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchPokemon() {
        let pokemonInstance = Pokemon(pokedexNumber: pokedexNumber)
        pokemonInstance.fetchItems { result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    self.pokemonName.text = info.name.capitalizingFirstLetter()
                    self.pokedexNum.text = "# \(self.pokedexNumber)"
                    if let firstType = info.types.first {
                        self.firstType.text = firstType.rawValue.capitalizingFirstLetter()
                        self.formatTypeBackground(order: .primary, type: firstType)
                    }
                    
                    if let secondType = info.types[safe: 1] {
                        self.secondType.text = secondType.rawValue.capitalizingFirstLetter()
                        self.formatTypeBackground(order: .secondary, type: secondType)
                    } else {
                        self.secondType.textColor = .clear
                        self.secondType.backgroundColor = .clear
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchDexEntires() {
        let dexInstance = DexEntries(pokedexNumber: pokedexNumber)
        dexInstance.fetchItems { result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    self.dexDescriptions.text = self.checkDescription(info: info).replacingOccurrences(of: "\n", with: " ")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func checkDescription(info: StoreDexEntire) -> String {
        return info.flavor_text_entries.last { entries in
            return entries.language.isEnglish && !entries.version.isGenOne
        }?.flavor_text ?? ""
    }
    
    func formatTypeBackground(order: TypeOrder, type: PokemonType) {
        let label: UILabel
        
        switch order {
        case .primary:
            label = firstType
        case .secondary:
            label = secondType
        }
        
        label.backgroundColor = type.color
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8.0
        label.textColor = .white
    }
    
    enum TypeOrder {
        case primary, secondary
    }
}

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

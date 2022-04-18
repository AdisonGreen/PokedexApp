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
                    if info.types.count == 2 {
                        self.firstType.text = info.types.first?.type.name.capitalizingFirstLetter()
                        self.secondType.text = info.types.last?.type.name.capitalizingFirstLetter()
                    } else {
                        self.firstType.text = info.types.first?.type.name.capitalizingFirstLetter()
                        self.secondType.textColor = .clear
                        self.secondType.backgroundColor = .clear
                    }
                    self.formatFirstTypeBackground()
                    self.formatSecondTypeBackground()
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
                    self.dexDescriptions.text = self.checkGame(info: info)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func checkGame(info: StoreDexEntire) -> String {
        var index = 0
        
        while info.flavor_text_entries[index].version.name != "alpha-sapphire" {
            if info.flavor_text_entries[index].version.name == "ultra-sun" && info.flavor_text_entries[index].language.name == "en" {
                return info.flavor_text_entries[index].flavor_text
            } else if info.flavor_text_entries[index].version.name == "sword" && info.flavor_text_entries[index].language.name == "en" {
                return info.flavor_text_entries[index].flavor_text
            } else {
                index += 1
            }
        }
        
        while info.flavor_text_entries[index].version.name == "alpha-sapphire" && info.flavor_text_entries[index].language.name != "en" {
            
        }
        
        return info.flavor_text_entries[index].flavor_text
    }
    
    func checkLanguageAndGame(info: StoreDexEntire) -> String {
        var index = 0

        while info.flavor_text_entries[index].language.name != "en" {
            index += 1
        }
        
        return info.flavor_text_entries[index].flavor_text
    }
    
    func formatFirstTypeBackground() {
        if firstType.text == "Grass" {
            firstType.backgroundColor = UIColor(cgColor: CGColor(red: 0.3, green: 0.9, blue: 0.3, alpha: 1.0))
            firstType.layer.masksToBounds = true
            firstType.layer.cornerRadius = 8.0
            firstType.textColor = .white
        }
        if firstType.text == "Poison" {
            firstType.backgroundColor = UIColor(cgColor: CGColor(red: 0.5, green: 0.1, blue: 0.5, alpha: 1.0))
            firstType.layer.masksToBounds = true
            firstType.layer.cornerRadius = 8.0
            firstType.textColor = .white
        }
        if firstType.text == "Fire" {
            firstType.backgroundColor = UIColor(cgColor: CGColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0))
            firstType.layer.masksToBounds = true
            firstType.layer.cornerRadius = 8.0
            firstType.textColor = .white
        }
        if firstType.text == "Flying" {
            firstType.backgroundColor = UIColor(cgColor: CGColor(red: 0.1, green: 0.7, blue: 0.8, alpha: 1.0))
            firstType.layer.masksToBounds = true
            firstType.layer.cornerRadius = 8.0
            firstType.textColor = .white
        }
        if firstType.text == "Bug" {
            firstType.backgroundColor = UIColor(cgColor: CGColor(red: 0.2, green: 0.4, blue: 0.1, alpha: 1.0))
            firstType.layer.masksToBounds = true
            firstType.layer.cornerRadius = 8.0
            firstType.textColor = .white
        }
        if firstType.text == "Normal" {
            firstType.backgroundColor = UIColor(cgColor: CGColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0))
            firstType.layer.masksToBounds = true
            firstType.layer.cornerRadius = 8.0
            firstType.textColor = .white
        }
        if firstType.text == "Electric" {
            firstType.backgroundColor = UIColor(cgColor: CGColor(red: 0.9, green: 0.9, blue: 0.1, alpha: 1.0))
            firstType.layer.masksToBounds = true
            firstType.layer.cornerRadius = 8.0
            firstType.textColor = .white
        }
        if firstType.text == "Rock" {
            firstType.backgroundColor = UIColor(cgColor: CGColor(red: 0.5, green: 0.4, blue: 0.2, alpha: 1.0))
            firstType.layer.masksToBounds = true
            firstType.layer.cornerRadius = 8.0
            firstType.textColor = .white
        }
        if firstType.text == "Ground" {
            firstType.backgroundColor = UIColor(cgColor: CGColor(red: 0.7, green: 0.5, blue: 0.1, alpha: 1.0))
            firstType.layer.masksToBounds = true
            firstType.layer.cornerRadius = 8.0
            firstType.textColor = .white
        }
        if firstType.text == "Water" {
            firstType.backgroundColor = UIColor(cgColor: CGColor(red: 0.1, green: 0.5, blue: 0.9, alpha: 1.0))
            firstType.layer.masksToBounds = true
            firstType.layer.cornerRadius = 8.0
            firstType.textColor = .white
        }
        if firstType.text == "Fairy" {
            firstType.backgroundColor = UIColor(cgColor: CGColor(red: 0.9, green: 0.5, blue: 0.6, alpha: 1.0))
            firstType.layer.masksToBounds = true
            firstType.layer.cornerRadius = 8.0
            firstType.textColor = .white
        }
        if firstType.text == "Fighting" {
            firstType.backgroundColor = UIColor(cgColor: CGColor(red: 0.9, green: 0.4, blue: 0.1, alpha: 1.0))
            firstType.layer.masksToBounds = true
            firstType.layer.cornerRadius = 8.0
            firstType.textColor = .white
        }
        if firstType.text == "Psychic" {
            firstType.backgroundColor = UIColor(cgColor: CGColor(red: 0.9, green: 0.3, blue: 0.4, alpha: 1.0))
            firstType.layer.masksToBounds = true
            firstType.layer.cornerRadius = 8.0
            firstType.textColor = .white
        }
        if firstType.text == "Ice" {
            firstType.backgroundColor = UIColor(cgColor: CGColor(red: 0.3, green: 0.7, blue: 0.9, alpha: 1.0))
            firstType.layer.masksToBounds = true
            firstType.layer.cornerRadius = 8.0
            firstType.textColor = .white
        }
        if firstType.text == "Dragon" {
            firstType.backgroundColor = UIColor(cgColor: CGColor(red: 0.3, green: 0.3, blue: 0.9, alpha: 1.0))
            firstType.layer.masksToBounds = true
            firstType.layer.cornerRadius = 8.0
            firstType.textColor = .white
        }
        if firstType.text == "Steel" {
            firstType.backgroundColor = UIColor(cgColor: CGColor(red: 0.8, green: 0.8, blue: 0.9, alpha: 1.0))
            firstType.layer.masksToBounds = true
            firstType.layer.cornerRadius = 8.0
            firstType.textColor = .white
        }
        if firstType.text == "Ghost" {
            firstType.backgroundColor = UIColor(cgColor: CGColor(red: 0.6, green: 0.4, blue: 0.6, alpha: 1.0))
            firstType.layer.masksToBounds = true
            firstType.layer.cornerRadius = 8.0
            firstType.textColor = .white
        }
        if firstType.text == "Dark" {
            firstType.backgroundColor = UIColor(cgColor: CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
            firstType.layer.masksToBounds = true
            firstType.layer.cornerRadius = 8.0
            firstType.textColor = .white
        }
    }
    
    func formatSecondTypeBackground() {
        if secondType.text == "Grass" {
            secondType.backgroundColor = UIColor(cgColor: CGColor(red: 0.3, green: 0.9, blue: 0.3, alpha: 1.0))
            secondType.layer.masksToBounds = true
            secondType.layer.cornerRadius = 8.0
            secondType.textColor = .white
        }
        if secondType.text == "Poison" {
            secondType.backgroundColor = UIColor(cgColor: CGColor(red: 0.5, green: 0.1, blue: 0.5, alpha: 1.0))
            secondType.layer.masksToBounds = true
            secondType.layer.cornerRadius = 8.0
            secondType.textColor = .white
        }
        if secondType.text == "Fire" {
            secondType.backgroundColor = UIColor(cgColor: CGColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0))
            secondType.layer.masksToBounds = true
            secondType.layer.cornerRadius = 8.0
            secondType.textColor = .white
        }
        if secondType.text == "Flying" {
            secondType.backgroundColor = UIColor(cgColor: CGColor(red: 0.1, green: 0.7, blue: 0.8, alpha: 1.0))
            secondType.layer.masksToBounds = true
            secondType.layer.cornerRadius = 8.0
            secondType.textColor = .white
        }
        if secondType.text == "Bug" {
            secondType.backgroundColor = UIColor(cgColor: CGColor(red: 0.2, green: 0.4, blue: 0.1, alpha: 1.0))
            secondType.layer.masksToBounds = true
            secondType.layer.cornerRadius = 8.0
            secondType.textColor = .white
        }
        if secondType.text == "Normal" {
            secondType.backgroundColor = UIColor(cgColor: CGColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0))
            secondType.layer.masksToBounds = true
            secondType.layer.cornerRadius = 8.0
            secondType.textColor = .white
        }
        if secondType.text == "Electric" {
            secondType.backgroundColor = UIColor(cgColor: CGColor(red: 0.9, green: 0.9, blue: 0.1, alpha: 1.0))
            secondType.layer.masksToBounds = true
            secondType.layer.cornerRadius = 8.0
            secondType.textColor = .white
        }
        if secondType.text == "Rock" {
            secondType.backgroundColor = UIColor(cgColor: CGColor(red: 0.5, green: 0.4, blue: 0.2, alpha: 1.0))
            secondType.layer.masksToBounds = true
            secondType.layer.cornerRadius = 8.0
            secondType.textColor = .white
        }
        if secondType.text == "Ground" {
            secondType.backgroundColor = UIColor(cgColor: CGColor(red: 0.7, green: 0.5, blue: 0.1, alpha: 1.0))
            secondType.layer.masksToBounds = true
            secondType.layer.cornerRadius = 8.0
            secondType.textColor = .white
        }
        if secondType.text == "Water" {
            secondType.backgroundColor = UIColor(cgColor: CGColor(red: 0.1, green: 0.5, blue: 0.9, alpha: 1.0))
            secondType.layer.masksToBounds = true
            secondType.layer.cornerRadius = 8.0
            secondType.textColor = .white
        }
        if secondType.text == "Fairy" {
            secondType.backgroundColor = UIColor(cgColor: CGColor(red: 0.9, green: 0.5, blue: 0.6, alpha: 1.0))
            secondType.layer.masksToBounds = true
            secondType.layer.cornerRadius = 8.0
            secondType.textColor = .white
        }
        if secondType.text == "Fighting" {
            secondType.backgroundColor = UIColor(cgColor: CGColor(red: 0.9, green: 0.4, blue: 0.1, alpha: 1.0))
            secondType.layer.masksToBounds = true
            secondType.layer.cornerRadius = 8.0
            secondType.textColor = .white
        }
        if secondType.text == "Psychic" {
            secondType.backgroundColor = UIColor(cgColor: CGColor(red: 0.9, green: 0.3, blue: 0.4, alpha: 1.0))
            secondType.layer.masksToBounds = true
            secondType.layer.cornerRadius = 8.0
            secondType.textColor = .white
        }
        if secondType.text == "Ice" {
            secondType.backgroundColor = UIColor(cgColor: CGColor(red: 0.3, green: 0.7, blue: 0.9, alpha: 1.0))
            secondType.layer.masksToBounds = true
            secondType.layer.cornerRadius = 8.0
            secondType.textColor = .white
        }
        if secondType.text == "Dragon" {
            secondType.backgroundColor = UIColor(cgColor: CGColor(red: 0.3, green: 0.3, blue: 0.9, alpha: 1.0))
            secondType.layer.masksToBounds = true
            secondType.layer.cornerRadius = 8.0
            secondType.textColor = .white
        }
        if secondType.text == "Steel" {
            secondType.backgroundColor = UIColor(cgColor: CGColor(red: 0.8, green: 0.8, blue: 0.9, alpha: 1.0))
            secondType.layer.masksToBounds = true
            secondType.layer.cornerRadius = 8.0
            secondType.textColor = .white
        }
        if secondType.text == "Ghost" {
            secondType.backgroundColor = UIColor(cgColor: CGColor(red: 0.6, green: 0.4, blue: 0.6, alpha: 1.0))
            secondType.layer.masksToBounds = true
            secondType.layer.cornerRadius = 8.0
            secondType.textColor = .white
        }
        if secondType.text == "Dark" {
            secondType.backgroundColor = UIColor(cgColor: CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
            secondType.layer.masksToBounds = true
            secondType.layer.cornerRadius = 8.0
            secondType.textColor = .white
        }
    }
}

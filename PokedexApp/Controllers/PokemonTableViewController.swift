//
//  PokemonTableViewController.swift
//  PokedexApp
//
//  Created by Adison Green on 4/22/22.
//

import UIKit

class PokemonTableViewController: UITableViewController {

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
    }
    
    func configure(cell: PokemonTableViewCell, forItemAt indexPath: IndexPath) {
        let pokemonSpriteInstance = PokemonSprites(pokedexNumber: pokedexNumber)
        pokemonSpriteInstance.fetchItems { result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    cell.pokemonImage.image = info
                }
            case .failure(let error):
                print(error)
            }
        }
        
        let pokemonInstance = Pokemon(pokedexNumber: pokedexNumber)
        pokemonInstance.fetchItems { result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    self.navigationItem.title = info.name.capitalizingFirstLetter()
                    cell.nameLabel.text = info.name.capitalizingFirstLetter()
                    cell.pokedexNumberLabel.text = "# \(self.pokedexNumber)"
                    cell.firstAbilityNameLabel.text = info.abilities.first?.ability.name.capitalizingFirstLetter()
                    
                    if let typeOne = info.types.first {
                        cell.typeOneLabel.text = typeOne.rawValue.capitalizingFirstLetter()

                        cell.typeOneLabel.backgroundColor = typeOne.color
                        cell.typeOneLabel.layer.masksToBounds = true
                        cell.typeOneLabel.layer.cornerRadius = 8.0
                        cell.typeOneLabel.textColor = .white
                    }
                    
                    if let secondType = info.types[safe: 1] {
                        cell.typeTwoLabel.text = secondType.rawValue.capitalizingFirstLetter()

                        cell.typeTwoLabel.backgroundColor = secondType.color
                        cell.typeTwoLabel.layer.masksToBounds = true
                        cell.typeTwoLabel.layer.cornerRadius = 8.0
                        cell.typeTwoLabel.textColor = .white
                    } else {
                        cell.typeTwoLabel.textColor = .clear
                        cell.typeTwoLabel.backgroundColor = .clear
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
        let dexInstance = DexEntries(pokedexNumber: pokedexNumber)
        dexInstance.fetchItems { result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    cell.descriptionLabel.text = self.checkDescription(info: info).replacingOccurrences(of: "\n", with: " ")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func checkDescription(info: StoreDexEntry) -> String {
        return info.flavor_text_entries.last { entries in
            return entries.language.isEnglish && !entries.version.isGenOne
        }?.flavor_text ?? ""
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonInfo", for: indexPath) as! PokemonTableViewCell
        
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
}

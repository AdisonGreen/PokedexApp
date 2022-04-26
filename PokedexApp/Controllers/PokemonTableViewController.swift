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
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func fetchTypesAndConfigure(cell: PokemonTypesTableViewCell, forItemAt indexPath: IndexPath) {
        let pokemonInstance = Pokemon(pokedexNumber: pokedexNumber)
        pokemonInstance.fetchItems { result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    
//                    cell.firstAbilityNameLabel.text = info.abilities.first?.ability.name.capitalizingFirstLetter()

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
    }
    
    func fetchAndConfigureNameAndNumber(cell: PokemonNameAndNumberTableViewCell, forItemAt indexPath: IndexPath) {
        let pokemonInstance = Pokemon(pokedexNumber: pokedexNumber)
        pokemonInstance.fetchItems { result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    
                    self.navigationItem.title = info.name.capitalizingFirstLetter()
                    cell.nameLabel.text = info.name.capitalizingFirstLetter()
                    cell.pokedexNumberLabel.text = "# \(self.pokedexNumber)"
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchImageAndConfigure(cell: PokemonImageTableViewCell, forItemAt indexPath: IndexPath) {
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
    }
    
    func fetchDescriptionAndConfigure(cell: PokemonDescriptionTableViewCell, forItemAt indexPath: IndexPath) {
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonNameAndNumber", for: indexPath) as! PokemonNameAndNumberTableViewCell
            
            fetchAndConfigureNameAndNumber(cell: cell, forItemAt: indexPath)
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonImage", for: indexPath) as! PokemonImageTableViewCell
            
            fetchImageAndConfigure(cell: cell, forItemAt: indexPath)
            
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTypes", for: indexPath) as! PokemonTypesTableViewCell
            
            fetchTypesAndConfigure(cell: cell, forItemAt: indexPath)
            
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonDescription", for: indexPath) as! PokemonDescriptionTableViewCell
            
            fetchDescriptionAndConfigure(cell: cell, forItemAt: indexPath)
            
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonAbilities", for: indexPath) as! PokemonAbilitesTableViewCell
            
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "Should never happen", for: indexPath)
        }
    }
}

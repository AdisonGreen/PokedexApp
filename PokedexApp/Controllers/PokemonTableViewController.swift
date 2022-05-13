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
        tableView.separatorStyle = .none
    }
    
    func fetchAbilitesAndConfigure(cell: PokemonAbilitesTableViewCell, forItemAt indexPath: IndexPath) {
        let pokemonInstance = Pokemon(pokedexNumber: pokedexNumber)
        pokemonInstance.fetchItems { result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    
                    if info.abilities.count == 1 {
                        cell.firstAbilityNameLabel.text = info.abilities.first?.ability.name.capitalizingFirstLetter()
                        cell.firstAbilityNameLabel.textColor = .systemGreen
                        
                        if info.abilities.first?.is_hidden == true {
                            cell.firstAbilityNameLabel.text! += " - Hidden Ability"
                        }
                        
                        let abilityDescriptionsInstance = AbilityDescriptions()
                        abilityDescriptionsInstance.fetchItems(url: (info.abilities.first?.ability.url)!) { descriptionResult in
                            switch descriptionResult {
                            case .success(let descriptionInfo):
                                DispatchQueue.main.async {
                                    cell.firstAbilityDescriptionLabel.text = self.checkAbilityDescription(info: descriptionInfo).replacingOccurrences(of: "\n", with: " ")
                                }
                                
                            case .failure(let error):
                                print(error)
                            }
                        }
                        
                        cell.secondAbilityNameLabel.isHidden = true
                        cell.secondAbilityDescriptionLabel.isHidden = true
                        
                        cell.thirdAbiltyNameLabel.isHidden = true
                        cell.thirdAbilityDescriptionLabel.isHidden = true
                    } else if info.abilities.count == 2 {
                        cell.firstAbilityNameLabel.text = info.abilities.first?.ability.name.capitalizingFirstLetter()
                        cell.firstAbilityNameLabel.textColor = .systemGreen
                        
                        let abilityDescriptionsInstance = AbilityDescriptions()
                        abilityDescriptionsInstance.fetchItems(url: (info.abilities.first?.ability.url)!) { descriptionResult in
                            switch descriptionResult {
                            case .success(let descriptionInfo):
                                DispatchQueue.main.async {
                                    cell.firstAbilityDescriptionLabel.text = self.checkAbilityDescription(info: descriptionInfo).replacingOccurrences(of: "\n", with: " ")
                                    
                                }
                                
                            case .failure(let error):
                                print(error)
                            }
                        }
                        
                        cell.secondAbilityNameLabel.text = info.abilities.last?.ability.name.capitalizingFirstLetter()
                        cell.secondAbilityNameLabel.textColor = .systemGreen
                        
                        abilityDescriptionsInstance.fetchItems(url: (info.abilities.last?.ability.url)!) { descriptionResult in
                            switch descriptionResult {
                            case .success(let descriptionInfo):
                                DispatchQueue.main.async {
                                    cell.secondAbilityDescriptionLabel.text = self.checkAbilityDescription(info: descriptionInfo).replacingOccurrences(of: "\n", with: " ")
                                }
                                
                            case .failure(let error):
                                print(error)
                            }
                        }
                        
                        if info.abilities.last?.is_hidden == true {
                            cell.secondAbilityNameLabel.text! += " - Hidden Ability"
                        } else if info.abilities.first?.is_hidden == true {
                            cell.firstAbilityNameLabel.text! += " - Hidden Ability"
                        }
                        
                        cell.thirdAbiltyNameLabel.isHidden = true
                        cell.thirdAbilityDescriptionLabel.isHidden = true
                    } else {
                        cell.firstAbilityNameLabel.text = info.abilities[0].ability.name.capitalizingFirstLetter()
                        cell.firstAbilityNameLabel.textColor = .systemGreen
                        
                        let abilityDescriptionsInstance = AbilityDescriptions()
                        abilityDescriptionsInstance.fetchItems(url: info.abilities[0].ability.url) { descriptionResult in
                            switch descriptionResult {
                            case .success(let descriptionInfo):
                                DispatchQueue.main.async {
                                    cell.firstAbilityDescriptionLabel.text = self.checkAbilityDescription(info: descriptionInfo).replacingOccurrences(of: "\n", with: " ")
                                }
                                
                            case .failure(let error):
                                print(error)
                            }
                        }
                        
                        cell.secondAbilityNameLabel.text = info.abilities[1].ability.name.capitalizingFirstLetter()
                        cell.secondAbilityNameLabel.textColor = .systemGreen
                        
                        abilityDescriptionsInstance.fetchItems(url: info.abilities[1].ability.url) { descriptionResult in
                            switch descriptionResult {
                            case .success(let descriptionInfo):
                                DispatchQueue.main.async {
                                    cell.secondAbilityDescriptionLabel.text = self.checkAbilityDescription(info: descriptionInfo).replacingOccurrences(of: "\n", with: " ")
                                }
                                
                            case .failure(let error):
                                print(error)
                            }
                        }
                        
                        cell.thirdAbiltyNameLabel.text = info.abilities[2].ability.name.capitalizingFirstLetter()
                        cell.thirdAbiltyNameLabel.textColor = .systemGreen
                        
                        abilityDescriptionsInstance.fetchItems(url: info.abilities[2].ability.url) { descriptionResult in
                            switch descriptionResult {
                            case .success(let descriptionInfo):
                                DispatchQueue.main.async {
                                    cell.thirdAbilityDescriptionLabel.text = self.checkAbilityDescription(info: descriptionInfo).replacingOccurrences(of: "\n", with: " ")
                                }
                                
                            case .failure(let error):
                                print(error)
                            }
                        }
                        
                        if info.abilities[0].is_hidden == true {
                            cell.firstAbilityNameLabel.text! += " - Hidden Ability"
                        } else if info.abilities[1].is_hidden == true {
                            cell.secondAbilityNameLabel.text! += " - Hidden Ability"
                        } else if info.abilities[2].is_hidden == true {
                            cell.thirdAbiltyNameLabel.text! += " - Hidden Ability"
                        }
                    }
                    self.tableView.reloadData()
            }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchTypesAndConfigure(cell: PokemonTypesTableViewCell, forItemAt indexPath: IndexPath) {
        let pokemonInstance = Pokemon(pokedexNumber: pokedexNumber)
        pokemonInstance.fetchItems { result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {

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
    
    func fetchImageAndConfigure(cell: PokemonImageTableViewCell, pokemonNum: Int) {
        cell.pokemonImage.image = UIImage(named: "\(pokemonNum)")
    }
    
    func fetchDescriptionAndConfigure(cell: PokemonDescriptionTableViewCell, forItemAt indexPath: IndexPath) {
        let dexInstance = DexEntries(pokedexNumber: pokedexNumber)
        dexInstance.fetchItems { result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    cell.descriptionLabel.text = self.checkDescription(info: info).replacingOccurrences(of: "\n", with: " ")
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchStatsAndConfigure(cell: PokemonStatsTableViewCell, forItemAt indexPath: IndexPath) {
        let statsInstance = PokemonStats(pokedexNumber: pokedexNumber)
        statsInstance.fetchItems { result in
            switch result {
            case.success(let info):
                DispatchQueue.main.async {
                    cell.hpStatLabel.text = info.stats[0].base_stat.description
                    cell.hpStatLabel.textColor = self.checkStatColor(stat: info.stats[0].base_stat)
                    
                    cell.attStatLabel.text = info.stats[1].base_stat.description
                    cell.attStatLabel.textColor = self.checkStatColor(stat: info.stats[1].base_stat)
                    
                    cell.defStatLabel.text = info.stats[2].base_stat.description
                    cell.defStatLabel.textColor = self.checkStatColor(stat: info.stats[2].base_stat)
                    
                    cell.sAttStatLabel.text = info.stats[3].base_stat.description
                    cell.sAttStatLabel.textColor = self.checkStatColor(stat: info.stats[3].base_stat)
                    
                    cell.sDefStatLabel.text = info.stats[4].base_stat.description
                    cell.sDefStatLabel.textColor = self.checkStatColor(stat: info.stats[4].base_stat)
                    
                    cell.speStatLabel.text = info.stats[5].base_stat.description
                    cell.speStatLabel.textColor = self.checkStatColor(stat: info.stats[5].base_stat)
                    
                    let total = (info.stats[0].base_stat + info.stats[1].base_stat) + (info.stats[2].base_stat + info.stats[3].base_stat) + (info.stats[4].base_stat + info.stats[5].base_stat)
                    
                    cell.totalStatLabel.text = total.description
                }
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func checkStatColor(stat: Int) -> UIColor {
        if stat < 40 { // 1 to 39
            return .systemRed
        } else if stat < 80 { // 40 to 79
            return .systemOrange
        } else if stat < 100 { // 80 to 99
            return .systemYellow
        } else if stat < 150 { // 100 to 149
            return .systemGreen
        } else  if stat < 250 { // 150 to 255
            return .systemTeal
        } else {
            return .systemTeal
        }
    }
    
    func checkDescription(info: StoreDexEntry) -> String {
        return info.flavor_text_entries.last { entries in
            return entries.language.isEnglish && !entries.version.isGenOne
        }?.flavor_text ?? ""
    }
    
    func checkAbilityDescription(info: StoreAbilityDescriptions) -> String {
        return info.flavor_text_entries.last { entries in
            return entries.language.isEnglish
        }?.flavor_text ?? ""
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonNameAndNumber", for: indexPath) as! PokemonNameAndNumberTableViewCell
            
            fetchAndConfigureNameAndNumber(cell: cell, forItemAt: indexPath)
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonImage", for: indexPath) as! PokemonImageTableViewCell
            
            fetchImageAndConfigure(cell: cell, pokemonNum: pokedexNumber)
            
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTypes", for: indexPath) as! PokemonTypesTableViewCell
            
            fetchTypesAndConfigure(cell: cell, forItemAt: indexPath)
            
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonDescription", for: indexPath) as! PokemonDescriptionTableViewCell
            
            fetchDescriptionAndConfigure(cell: cell, forItemAt: indexPath)
            
            return cell
        } else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonAbilities", for: indexPath) as! PokemonAbilitesTableViewCell
            
            fetchAbilitesAndConfigure(cell: cell, forItemAt: indexPath)
            
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonStats", for: indexPath) as! PokemonStatsTableViewCell
            
            fetchStatsAndConfigure(cell: cell, forItemAt: indexPath)
            
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "Should never happen", for: indexPath)
        }
    }
}

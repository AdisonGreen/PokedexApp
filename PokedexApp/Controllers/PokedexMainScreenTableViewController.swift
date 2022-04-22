//
//  TableViewController.swift
//  PokedexApp
//
//  Created by Adison Green on 3/11/22.
//

import UIKit

class PokedexMainScreenTableViewController: UITableViewController {
    
    var items = [StoreAllPokemon]()
    
    var pokemonInstance = PokemonInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMatchingItems()
    }
    
    func fetchMatchingItems() {
        self.items = []
        self.tableView.reloadData()
        
        pokemonInstance.fetchItems { result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    self.items = info
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configure(cell: PokemonMainScreenTableViewCell, forItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        cell.pokemonName.text = item.name.capitalizingFirstLetter()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pokemon", for: indexPath) as! PokemonMainScreenTableViewCell
        
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    @IBSegueAction func pokemonTapped(_ coder: NSCoder, sender: Any?) -> PokemonTableViewController? {
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
            return nil
        }
        
        return PokemonTableViewController(coder: coder, pokedexNumber: (indexPath.row + 1))
    }
}

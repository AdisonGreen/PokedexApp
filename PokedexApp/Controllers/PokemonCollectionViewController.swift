//
//  PokemonCollectionViewController.swift
//  PokedexApp
//
//  Created by Adison Green on 5/9/22.
//

import UIKit

private let reuseIdentifier = "CollectionPokemonCell"

class PokemonCollectionViewController: UICollectionViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController()
    
    var items = [StoreAllPokemon]()
    lazy var filteredItems: [StoreAllPokemon] = self.items
    
    let myItems = ["Some", "Dude"]
    
    var pokemonInstance = PokemonInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllPokemon()
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text,
               searchString.isEmpty == false {
                filteredItems = items.filter { (item) -> Bool in
                    item.name.localizedCaseInsensitiveContains(searchString)
                }
            } else {
                filteredItems = items
            }
//
//            itemsByInitialLetter = filteredItems.reduce([:]) {
//               existing, element in
//                return existing.merging([element.first!:[element]]) { old,
//                   new in
//                    return old + new
//                }
//            }
//
//            initialLetters = itemsByInitialLetter.keys.sorted()
        
            collectionView.reloadData()
    }
    
    func generateLayout() -> UICollectionViewLayout {
        
        let spacing: CGFloat = 10
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(70.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = spacing
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func fetchAllPokemon() {
        self.items = []
        self.collectionView.reloadData()
        
        pokemonInstance.fetchItems { result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    self.items = info
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBSegueAction func pokemonCollectionTapped(_ coder: NSCoder, sender: Any?) -> PokemonTableViewController? {
        guard let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell) else {
            return nil
        }
        
        return PokemonTableViewController(coder: coder, pokedexNumber: (indexPath.row + 1))
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokemonCollectionViewCell
    
        // Configure the cell
        cell.pokemonNameLabel.text = filteredItems[indexPath.item].name.capitalizingFirstLetter()
//        items[indexPath.item].isEnglish = indexPath.rowvar isEnglish: Bool {
        return name == "en"
    }
        
        return cell
    }
}
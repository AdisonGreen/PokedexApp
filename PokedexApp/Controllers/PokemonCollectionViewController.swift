//
//  PokemonCollectionViewController.swift
//  PokedexApp
//
//  Created by Adison Green on 5/9/22.
//

import UIKit

private let reuseIdentifier = "CollectionPokemonCell"

private let otherIdentifier = "OtherCell"

class PokemonCollectionViewController: UICollectionViewController, UISearchResultsUpdating {
    @IBOutlet weak var layoutButton: UIBarButtonItem!
    
    var layout: [Layout: UICollectionViewLayout] = [:]
    
    let searchController = UISearchController()
    
    let pokemonSpeciesInstance = PokemonSpecies()
    
    var items = [StoreAllPokemon]()
    lazy var filteredItems: [StoreAllPokemon] = self.items
    var imageItems = [UIImage]()
//    lazy var filteredImages: [UIImage] = self.imageItems
    
    var pokemonInstance = PokemonInfo()
    
    enum Layout {
        case grid
        case column
    }
    
    var activeLayout: Layout = .grid {
        didSet {
            if let layout = layout[activeLayout] {
                self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems)
                
                collectionView.setCollectionViewLayout(layout, animated: true) { (_) in
                    switch self.activeLayout {
                    case .grid:
                        self.layoutButton.image = UIImage(systemName: "square.grid.2x2")
                    case .column:
                        self.layoutButton.image = UIImage(systemName: "rectangle.grid.1x2")
                    }
                }
                
            }
        }
    }

    override func viewDidLoad() {
        fetchAllPokemon()
        
        super.viewDidLoad()
        
        layout[.grid] = generateLayout()
        layout[.column] = generateOtherLayout()
        
        if let layout = layout[activeLayout] {
            collectionView.collectionViewLayout = layout
        }
        
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
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
    
    func generateOtherLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 10
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(70.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = spacing
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 10
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(70.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = spacing
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func fetchAllPokemon() {
        self.items = []
        
        pokemonInstance.fetchItems { result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    self.items = info
                    self.filteredItems = self.items
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func switchLayouts(_ sender: UIBarButtonItem) {
        switch activeLayout {
        case .grid:
            activeLayout = .column
        case .column:
            activeLayout = .grid
        }
    }
    
    @IBSegueAction func pokemonOtherTapped(_ coder: NSCoder, sender: Any?) -> PokemonTableViewController? {
        guard let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell) else {
            return nil
        }
        
        return PokemonTableViewController(coder: coder, pokedexNumber: filteredItems[indexPath.row].pokedexNumber)
    }
    
    @IBSegueAction func pokemonCollectionTapped(_ coder: NSCoder, sender: Any?) -> PokemonTableViewController? {
        guard let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell) else {
            return nil
        }
        
        return PokemonTableViewController(coder: coder, pokedexNumber: filteredItems[indexPath.row].pokedexNumber)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = activeLayout == .grid ? reuseIdentifier : otherIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PokemonCollectionViewCell
    
        // Configure the cell
        if identifier == reuseIdentifier {
            cell.pokemonNameLabel.isHidden = true
            
            cell.pokemonImageView.image = UIImage(named: "\(filteredItems[indexPath.row].pokedexNumber)")
        } else {
            cell.pokemonNameLabel.isHidden = false
            cell.pokemonNameLabel.text = filteredItems[indexPath.item].name.capitalizingFirstLetter()
            
            cell.pokemonImageView.image = UIImage(named: "\(filteredItems[indexPath.row].pokedexNumber)")
        }
        
        return cell
    }
}

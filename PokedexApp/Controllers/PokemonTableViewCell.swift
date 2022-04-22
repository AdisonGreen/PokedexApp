//
//  PokemonTableViewCell.swift
//  PokedexApp
//
//  Created by Adison Green on 4/22/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    @IBOutlet weak var pokedexNumberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var typeOneLabel: UILabel!
    @IBOutlet weak var typeTwoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var firstAbilityNameLabel: UILabel!
    @IBOutlet weak var firstAbilityDescriptionLabel: UILabel!
    @IBOutlet weak var secondAbilityNameLabel: UILabel!
    @IBOutlet weak var secondAbilityDescriptionLabel: UILabel!
    @IBOutlet weak var thirdAbiltyNameLabel: UILabel!
    @IBOutlet weak var thirdAbilityDescriptionLabel: UILabel!
}

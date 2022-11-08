//
//  RecipeTableViewCell.swift
//  FetcherData
//
//  Created by Supodoco on 08.11.2022.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet var recipeImage: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cookingTimeLabel: UILabel!
    
    func configure(with recipe: Recipe) {
        cookingTimeLabel.text = "Cooking time: \(recipe.cooktime) min"
        
        nameLabel.text = recipe.name
        
        recipeImage.image = UIImage(named: "default")
        recipeImage.layer.cornerRadius = 15
        recipeImage.contentMode = .scaleAspectFill
        recipeImage.clipsToBounds = true
        
        NetworkManager.shared.fetchImage(from: recipe.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.recipeImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }

}

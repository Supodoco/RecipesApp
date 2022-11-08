//
//  NutritionTableViewCell.swift
//  FetcherData
//
//  Created by Supodoco on 08.11.2022.
//

import UIKit

class NutritionTableViewCell: UITableViewCell {
    
    @IBOutlet var finalViews: [UIView]!
    
    @IBOutlet var caloriesLabel: UILabel!
    @IBOutlet var fatLabel: UILabel!
    @IBOutlet var carbsLabel: UILabel!
    @IBOutlet var proteinLabel: UILabel!
    
    func configure(with recipe: Recipe) {
        finalViews.first?.layer.cornerRadius = 15
        finalViews.first?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        finalViews.last?.layer.cornerRadius = 15
        finalViews.last?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
        caloriesLabel.text = "Calories\n\(recipe.calories)"
        fatLabel.text      = "Fat\n\(recipe.fat)"
        carbsLabel.text    = "Carbs\n\(recipe.carbs)"
        proteinLabel.text  = "Protein\n\(recipe.protein)"
    }
}

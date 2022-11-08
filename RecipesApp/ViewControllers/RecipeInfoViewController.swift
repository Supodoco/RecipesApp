//
//  RecipeInfoViewController.swift
//  FetcherData
//
//  Created by Supodoco on 08.11.2022.
//

import UIKit

class RecipeInfoViewController: UITableViewController {
    
    var recipe: Recipe!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipe details"
        tableView.separatorStyle = .none
    }
}

// MARK: - Cell Configure
extension RecipeInfoViewController {
    private func configureCell(text: String, secondaryText: String) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = text
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 19)
        content.secondaryText = secondaryText
        content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - Table view data source
extension RecipeInfoViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.recipe.rawValue, for: indexPath)
            guard let cell = cell as? RecipeTableViewCell else { return UITableViewCell() }
            cell.configure(with: recipe)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.nutrition.rawValue, for: indexPath)
            guard let cell = cell as? NutritionTableViewCell else { return UITableViewCell() }
            cell.configure(with: recipe)
            return cell
        case 2:
            return configureCell(
                text: "Ingredients",
                secondaryText: (1...recipe.ingredients.count)
                    .map { "\($0). \(recipe.ingredients[$0 - 1])\n" }
                    .joined()
            )
        default:
            return configureCell(
                text: "Instructions",
                secondaryText: recipe.instructions
            )
        }
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 100
        case 1: return 60
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//
//  recipesTableViewController.swift
//  FetcherData
//
//  Created by Supodoco on 07.11.2022.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    private var recipes: Recipes = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
}

// MARK: - Table view data source
extension RecipesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        guard let cell = cell as? RecipeTableViewCell else { return UITableViewCell() }
        let recipe = recipes[indexPath.row]
        cell.configure(with: recipe)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

// MARK: - Navigation
extension RecipesTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let recipeInfoVC = segue.destination as? RecipeInfoViewController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        recipeInfoVC?.recipe = recipes[indexPath.row]
    }
}

// MARK: - FetchData
extension RecipesTableViewController {
    private func fetchData() {
        NetworkManager.shared.fetchRecipes(from: Link.dataUrl.rawValue) { [unowned self] result in
            switch result {
            case .success(let recipes):
                self.recipes = recipes
            case .failure(let error):
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

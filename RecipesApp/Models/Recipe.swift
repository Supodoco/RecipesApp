//
//  Beer.swift
//  FetcherData
//
//  Created by Supodoco on 04.11.2022.
//

import Foundation

struct Recipe: Decodable {
    let id, name, image, instructions: String
    let calories, fat, carbs, protein, cooktime: Int
    let ingredients: [String]
    
    init(recipeData: [String: Any]) {
        id = recipeData["id"] as? String ?? ""
        name = recipeData["name"] as? String ?? ""
        image = recipeData["image"] as? String ?? ""
        instructions = recipeData["instructions"] as? String ?? ""
        calories = recipeData["calories"] as? Int ?? 0
        fat = recipeData["fat"] as? Int ?? 0
        carbs = recipeData["carbs"] as? Int ?? 0
        protein = recipeData["protein"] as? Int ?? 0
        cooktime = recipeData["cooktime"] as? Int ?? 0
        ingredients = recipeData["ingredients"] as? [String] ?? []
    }
    
    static func getRecipes(from value: Any) -> Recipes {
        guard let recipesData = value as? [[String: Any]] else { return [] }
        return recipesData.compactMap { Recipe(recipeData: $0) }
    }
}

typealias Recipes = [Recipe]

enum Cell: String {
    case recipe = "recipeCell"
    case nutrition = "nutritionCell"
}

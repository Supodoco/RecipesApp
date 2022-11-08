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
}

typealias Recipes = [Recipe]


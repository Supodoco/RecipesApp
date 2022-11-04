//
//  Beer.swift
//  FetcherData
//
//  Created by Supodoco on 04.11.2022.
//

import Foundation

struct Recipe: Decodable {
    let id: String
    let name: String
    let source: String
    let calories: Int
    let instructions: String
    let ingredients: [String]
    let tags: [String]
}

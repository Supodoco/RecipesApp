//
//  NetworkManager.swift
//  FetcherData
//
//  Created by Supodoco on 07.11.2022.
//

import UIKit
import Alamofire

enum Link: String {
    case dataUrl = "https://pastebin.com/raw/Ki915f1w"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchRecipes(from url: String, completion: @escaping (Result<Recipes, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let recipesData):
                    completion(.success(Recipe.getRecipes(from: recipesData)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    func fetchData(from url: String, completion: @escaping (Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let dataImage):
                    completion(.success(dataImage))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

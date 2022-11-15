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
    
    private let cacheImages = NSCache<NSString, UIImage>()
    
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
    func fetchImage(from url: String, completion: @escaping (Result<UIImage, AFError>) -> Void) {
        if let image = cacheImages.object(forKey: url as NSString) {
            completion(.success(image))
        } else {
            AF.request(url)
                .validate()
                .responseData { [weak self] dataResponse in
                    switch dataResponse.result {
                    case .success(let dataImage):
                        if let image = UIImage(data: dataImage) {
                            self?.cacheImages.setObject(
                                image,
                                forKey: url as NSString
                            )
                            completion(.success(image))
                        } else {
                            completion(.failure(.invalidURL(url: url)))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    }
}

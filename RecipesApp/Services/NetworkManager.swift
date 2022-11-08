//
//  NetworkManager.swift
//  FetcherData
//
//  Created by Supodoco on 07.11.2022.
//

import UIKit

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum Link: String {
    case dataUrl = "https://pastebin.com/raw/Ki915f1w"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchRecipes(completion: @escaping (Result<Recipes, NetworkError>) -> ()) {
        guard let url = URL(string: Link.dataUrl.rawValue) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let recipes = try JSONDecoder().decode(Recipes.self, from: data)
                completion(.success(recipes))
            } catch let error {
                completion(.failure(.decodingError))
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchImage(from url: String?, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}

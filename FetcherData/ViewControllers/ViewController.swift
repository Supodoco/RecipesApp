//
//  ViewController.swift
//  FetcherData
//
//  Created by Supodoco on 04.11.2022.
//

import UIKit

enum Links: String {
    case dataUrl = "https://pastebin.com/raw/vtKX9UFX"
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDrinks()
    }
}

extension ViewController {
    private func fetchDrinks() {
        guard let url = URL(string: Links.dataUrl.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let drinks = try JSONDecoder().decode([String: Recipe].self, from: data)
                print(drinks)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}

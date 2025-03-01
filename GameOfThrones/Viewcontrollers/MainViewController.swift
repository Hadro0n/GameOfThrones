//
//  ViewController.swift
//  GameOfThrones
//
//  Created by Владислав Якунин on 25.02.2025.
//

import UIKit

final class MainViewController: UIViewController {
    // MARK: - Private properties
    private var quote: Quote?
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuote" {
            let destinationVC = segue.destination as? QuoteViewController
            destinationVC?.quote = self.quote
        }
    }
    
    // -MARK: IBActions
    @IBAction func getQuoteButtonPressed() {
        NetworkManager.shared.fetchRandomQuote { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let quote):
                        self?.quote = quote
                        self?.performSegue(withIdentifier: "showQuote", sender: self)
                    case .failure(let error):
                        print("Ошибка при получении цитаты: \(error.localizedDescription)")
                }
            }
        }
    }
}
    

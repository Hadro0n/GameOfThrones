//
//  QuoteViewController.swift
//  GameOfThrones
//
//  Created by Владислав Якунин on 01.03.2025.
//

import UIKit

final class QuoteViewController: UIViewController {
  
    // MARK: - IBOutlets
    @IBOutlet var heroImage: UIImageView!
    @IBOutlet var heroNameLabel: UILabel!
    @IBOutlet var quoteLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        fetchQuote()
    }
        
    // MARK: - IBActions
    @IBAction func refreshButtonPressed() {
        fetchQuote()
    }
    
    // MARK: - Private methods
    private func setupUI(with quote: Quote) {
        DispatchQueue.main.async {
            self.heroNameLabel.text = quote.character.name
            self.quoteLabel.text = quote.sentence
        
            if let characterImage = UIImage(named: quote.character.slug) {
                self.heroImage.image = characterImage
            } else {
                self.heroImage.image = UIImage(named: "default_character")
            }
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func fetchQuote() {
        activityIndicator.startAnimating()
        
        NetworkManager.shared.fetchRandomQuote { [weak self] result in
            switch result {
            case .success(let quote):
                self?.setupUI(with: quote)
            case .failure(let error):
                print("Ошибка при получении цитаты: \(error.localizedDescription)")
                DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
}

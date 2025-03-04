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
    @IBOutlet var activiryIndicator: UIActivityIndicatorView!
    
    // MARK: - Public properties
   
  
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        activiryIndicator.hidesWhenStopped = true
        fetchQuote()
    }
        
    // MARK: - IBActions
    @IBAction func refreshButtonPressed() {
        fetchQuote()
    }
    
    // MARK: - Private methods
    private func setupUI(with quote: Quote) {
        heroNameLabel.text = quote.character.name
        quoteLabel.text = quote.sentence
    
        if let characterImage = UIImage(named: quote.character.slug) {
            heroImage.image = characterImage
        } else {
            heroImage.image = UIImage(named: "default_character")
        }
        activiryIndicator.stopAnimating()
    }
    
    private func fetchQuote() {
        activiryIndicator.startAnimating()
        NetworkManager.shared.fetchRandomQuote { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let quote):
                    self?.setupUI(with: quote)
                    case .failure(let error):
                        print("Ошибка при получении цитаты: \(error.localizedDescription)")
                        self?.activiryIndicator.stopAnimating()
                }
            }
        }
    }
}

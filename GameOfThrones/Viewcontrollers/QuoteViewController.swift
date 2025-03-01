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
    
    // MARK: - Public properties
    var quote: Quote?
  
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
        
    // MARK: - Private methods
    private func setupUI() {
        guard let quote = quote else { return }

        heroNameLabel.text = quote.character.name
        quoteLabel.text = quote.sentence
    
        if let characterImage = UIImage(named: quote.character.slug) {
            heroImage.image = characterImage
        } else {
            heroImage.image = UIImage(named: "default_character")
        }
    }
}

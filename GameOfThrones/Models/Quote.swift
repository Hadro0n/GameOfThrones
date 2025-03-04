//
//  Quote.swift
//  GameOfThrones
//
//  Created by Владислав Якунин on 24.02.2025.
//

import Foundation

struct Quote: Decodable {
    let sentence: String
    let character: Hero
    
    init(sentence: String, character: Hero) {
        self.sentence = sentence
        self.character = character
    }
    
    init(quoteDetails: [String: Any]) {
        sentence = quoteDetails["sentence"] as? String ?? ""
        
        guard let characterDetails = quoteDetails["character"] as? [String: Any] else {
            character = Hero(name: "", slug: "")
            return
        }
        
        character = Hero(heroDetails: characterDetails)
    }
}

struct Hero: Decodable {
    let name: String
    let slug: String
    
    init(name: String, slug: String) {
        self.name = name
        self.slug = slug
    }
    
    init(heroDetails: [String: Any]) {
        name = heroDetails["name"] as? String ?? ""
        slug = heroDetails["slug"] as? String ?? ""
    }
}

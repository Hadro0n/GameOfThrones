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
}

struct Hero: Decodable {
    let name: String
    let slug: String
    let house: House
}

struct House: Decodable {
    let name: String
    let slug: String
}

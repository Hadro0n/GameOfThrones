//
//  NetworkManager.swift
//  GameOfThrones
//
//  Created by Владислав Якунин on 26.02.2025.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    // MARK: - Public propetries
    static let shared = NetworkManager()
    
    // MARK: - Private properties
    private let baseUrl = "https://api.gameofthronesquotes.xyz/v1/random"
    
    // MARK: - Public methods
        
    func fetchRandomQuote(completion: @escaping(Result<Quote, AFError>) -> Void) {
        AF.request(baseUrl, method: .get)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let json = value as? [String: Any] else { return }
                    guard let sentence = json["sentence"] as? String else { return }
                    guard let characterDict = json["character"] as? [String: Any] else { return }
                    
                    let character = Hero(heroDetails: characterDict)
                    let quote = Quote(quoteDetails: ["sentence": sentence, "character": characterDict])
                    
                    completion(.success(quote))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

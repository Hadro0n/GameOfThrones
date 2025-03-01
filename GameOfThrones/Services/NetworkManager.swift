//
//  NetworkManager.swift
//  GameOfThrones
//
//  Created by Владислав Якунин on 26.02.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}

final class NetworkManager {
    
    // MARK: - Public propetries
    static let shared = NetworkManager()
    
    // MARK: - Private properties
    private let baseUrl = URL(string: "https://api.gameofthronesquotes.xyz/v1/random")
    
    // MARK: - Public methods
    func fetchRandomQuote(completion: @escaping (Result<Quote, Error>) -> Void) {
        guard let url = baseUrl else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let quote = try decoder.decode(Quote.self, from: data)
                completion(.success(quote))
            } catch {
                completion(.failure(NetworkError.noData))
            }
            
        }.resume()
    }
}

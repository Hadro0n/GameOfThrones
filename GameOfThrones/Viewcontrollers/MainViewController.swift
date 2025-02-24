//
//  ViewController.swift
//  GameOfThrones
//
//  Created by Владислав Якунин on 25.02.2025.
//

import UIKit

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Готово!"
        case .failed:
            return "Ошибка!"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "Цитата получена. Можно посмотреть в консоли."
        case .failed:
            return "Цитата не получена. Попробуйте еще раз."
        }
    }
}

final class MainViewController: UIViewController {
    
// -MARK: IBActions
    @IBAction func getQuoteButtonPressed() {
        fetchQuote()
    }
    
// MARK: - Private Methods
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(
            title: status.title,
            message: status.message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Хорошо", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [unowned self] in
            present(alert, animated: true)
        }
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchQuote() {
        let url = URL(string: "https://api.gameofthronesquotes.xyz/v1/random")!
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self else { return }
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let quote = try JSONDecoder().decode(Quote.self, from: data)
                print(quote)
                
                DispatchQueue.main.sync {
                    self.showAlert(withStatus: .success)
                }
            } catch {
                print(error.localizedDescription)
                
                DispatchQueue.main.sync {
                    self.showAlert(withStatus: .failed)
                }
            }
        }.resume()
    }
}


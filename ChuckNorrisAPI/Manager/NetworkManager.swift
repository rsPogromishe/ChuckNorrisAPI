//
//  NetworkManager.swift
//  ChuckNorrisAPI
//
//  Created by Снытин Ростислав on 13.03.2022.
//

import UIKit

enum Response {
    case onSuccess(quote: Quote)
    case onError(error: Error)
}

class NetworkManager {
    
    var onCompletion: ((Response) -> Void)?
    
    func fetchQuote() {
        let urlString = "https://api.chucknorris.io/jokes/random"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                if let quote = self.parseJSON(withData: data) {
                    self.onCompletion?(.onSuccess(quote: quote))
                }
            } else if let error = error {
                self.onCompletion?(.onError(error: error))
            }
        }.resume()
    }
    
    private func parseJSON(withData data: Data) -> Quote? {
        let decoder = JSONDecoder()
        do {
            let quoteData = try decoder.decode(QuoteData.self, from: data)
            guard let quote = Quote(quoteData: quoteData) else {
                return nil
            }
            return quote
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}

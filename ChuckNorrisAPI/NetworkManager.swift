//
//  NetworkManager.swift
//  ChuckNorrisAPI
//
//  Created by Снытин Ростислав on 13.03.2022.
//

import Foundation
import UIKit

class NetworkManager {
    
    var onCompletion: ((Quote) -> Void)?
    
    func fetchQuote() {
        let urlString = "https://api.chucknorris.io/jokes/random"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let quote = self.parseJSON(withData: data) {
                    self.onCompletion?(quote)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> Quote? {
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

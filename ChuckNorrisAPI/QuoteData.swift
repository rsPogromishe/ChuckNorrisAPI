//
//  QuoteData.swift
//  ChuckNorrisAPI
//
//  Created by Снытин Ростислав on 13.03.2022.
//

import Foundation
import UIKit

struct QuoteData: Codable {
    
    let iconUrl: String
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case iconUrl = "icon_url"
        case value
    }
}

extension String {

        func stringToImage(_ handler: @escaping ((UIImage?)->())) {
            if let url = URL(string: self) {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        let image = UIImage(data: data)
                        handler(image)
                    }
                }.resume()
            }
        }
    }

//
//  QuoteData.swift
//  ChuckNorrisAPI
//
//  Created by Снытин Ростислав on 13.03.2022.
//

import UIKit

struct QuoteData: Codable {
    
    let iconUrl: String
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case iconUrl = "icon_url"
        case value
    }
}

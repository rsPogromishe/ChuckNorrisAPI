//
//  Quote.swift
//  ChuckNorrisAPI
//
//  Created by Снытин Ростислав on 13.03.2022.
//

import Foundation

struct Quote {
    let image: String
    let quote: String
    
    init?(quoteData: QuoteData) {
        image = quoteData.iconUrl
        quote = quoteData.value
    }
}


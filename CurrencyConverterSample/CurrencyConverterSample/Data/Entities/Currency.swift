//
//  Currency.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 10/06/2024.
//

import Foundation

enum Currency: String, CaseIterable {
    case USD
    case EUR
    case GBP
    case JPY
    
    var symbol: String {
        switch self {
        case .USD: "$"
        case .EUR: "€"
        case .GBP: "£"
        case .JPY: "¥"
        }
    }
}

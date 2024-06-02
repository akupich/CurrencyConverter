//
//  ExchangeRate.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 02/06/2024.
//

import Foundation

struct ExchangeAmount: Codable, Equatable {
    let amount: Double
    let currency: String
}

//
//  GetAllCurrenciesRepositoryImpl.swift
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
}

final class GetAllCurrenciesRepositoryImpl: GetAllCurrenciesRepository {
    
    init() {}
    
    func getAllCurrencies() -> [Currency] {
        Currency.allCases
    }
}

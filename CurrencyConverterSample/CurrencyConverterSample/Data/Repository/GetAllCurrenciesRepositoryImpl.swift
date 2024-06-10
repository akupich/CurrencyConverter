//
//  GetAllCurrenciesRepositoryImpl.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 10/06/2024.
//

import Foundation

final class GetAllCurrenciesRepositoryImpl: GetAllCurrenciesRepository {
    
    func getAllCurrencies() -> [Currency] {
        Currency.allCases
    }
}

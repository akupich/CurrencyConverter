//
//  GetAllCurrenciesRepository.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 10/06/2024.
//

import Foundation

protocol GetAllCurrenciesRepository {
    /// Get all supported currencies in the app
    ///
    /// - Returns: list of avaialble currencies
    func getAllCurrencies() -> [Currency]
}

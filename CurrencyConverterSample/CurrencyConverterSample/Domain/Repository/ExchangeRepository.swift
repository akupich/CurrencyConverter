//
//  ExchangeRepository.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 02/06/2024.
//

import Combine

protocol ExchangeRepository {
    /// Get ExchangeAmount for the given request
    ///
    /// - Parameter request: amount - given amount that needs to be converted,
    ///                      sourceCurrency - given currency have to be converted,
    ///                      targetCurrency - target currency required for conversion
    /// - Returns: publisher with exchanged amount based on required currency or api error
    func getConversionRate(_ request: ConversionRateRequest) -> AnyPublisher<ExchangeAmount?, Error>
}

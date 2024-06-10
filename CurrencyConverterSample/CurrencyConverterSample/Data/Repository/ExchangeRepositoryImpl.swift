//
//  ExchangeRepositoryImpl.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 02/06/2024.
//

import Combine

final class ExchangeRepositoryImpl: ExchangeRepository {
    private var networkService: NetworkServiceProtocol
    
    init(with networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getConversionRate(_ request: ConversionRateRequest) -> AnyPublisher<ExchangeAmount?, NetworkError> {
        return networkService.request(ExchangeEndpoint.exchange(from: request.sourceCurrency,
                                                                to: request.targetCurrency,
                                                                amount: request.amount))
        .eraseToAnyPublisher()
    }
}

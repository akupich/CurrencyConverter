//
//  ExchangeCurrencyUseCase.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 02/06/2024.
//

import Combine

protocol ExchangeCurrencyUseCaseble {
    func execute(with request: ConversionRateRequest) -> AnyPublisher<ExchangeAmount?, NetworkError>
}

final class ExchangeCurrencyUseCase: ExchangeCurrencyUseCaseble {

    private var repository: ExchangeRepository

    init(repository: ExchangeRepository) {
        self.repository = repository
    }

    func execute(with request: ConversionRateRequest) -> AnyPublisher<ExchangeAmount?, NetworkError> {
        repository.getConversionRate(request)
    }
}

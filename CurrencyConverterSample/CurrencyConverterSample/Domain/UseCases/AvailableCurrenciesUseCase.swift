//
//  AvailableCurrenciesUseCase.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 10/06/2024.
//

import Combine

protocol AvailableCurrenciesUseCaseble {
    func execute() -> [Currency]
}

final class AvailableCurrenciesUseCase: AvailableCurrenciesUseCaseble {

    private var repository: GetAllCurrenciesRepository

    init(repository: GetAllCurrenciesRepository) {
        self.repository = repository
    }

    func execute() -> [Currency] {
        repository.getAllCurrencies()
    }
}

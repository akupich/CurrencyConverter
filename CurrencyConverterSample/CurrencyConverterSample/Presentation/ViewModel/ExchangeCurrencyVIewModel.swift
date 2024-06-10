//
//  ExchangeCurrencyVIewModel.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 02/06/2024.
//

import Combine
import Foundation

enum State {
    case isLoading
    case failed(Error)
    case loaded(String)
}

protocol ExchangeCurrencyViewModelInput {
    var sourceCurrency: Currency? { get set }
    var targetCurrency: Currency? { get set }
    var amount: String { get set }
}

protocol ExchangeCurrencyViewModelOutput {
    var availableCurrencies: [Currency] { get }
    var state: PassthroughSubject<State, Never> { get }
}

typealias ExchangeCurrencyViewModel = ExchangeCurrencyViewModelInput & ExchangeCurrencyViewModelOutput

final class ExchangeCurrencyViewModelImpl: ExchangeCurrencyViewModel {
    @Published var sourceCurrency: Currency?
    @Published var targetCurrency: Currency?
    @Published var amount: String = ""
    
    let availableCurrencies: [Currency]
    var state: PassthroughSubject<State, Never> = .init()
    
    private let exchangeCurrencyUseCase: ExchangeCurrencyUseCaseble
    private let availableCurrenciesUseCase: AvailableCurrenciesUseCaseble
    
    private var timerCancellable: AnyCancellable?
    private var exchangeCancellable: AnyCancellable?
    private var cancellables: Set<AnyCancellable> = Set()
    
    init(exchangeCurrencyUseCase: ExchangeCurrencyUseCaseble, availableCurrenciesUseCase: AvailableCurrenciesUseCaseble) {
        self.availableCurrenciesUseCase = availableCurrenciesUseCase
        self.exchangeCurrencyUseCase = exchangeCurrencyUseCase
        
        self.availableCurrencies = availableCurrenciesUseCase.execute()
        self.sourceCurrency = availableCurrencies.first
        self.targetCurrency = availableCurrencies.first
        
        bindInputs()
    }
    
    private func bindInputs() {
        $amount
            .combineLatest($sourceCurrency, $targetCurrency)
            .dropFirst()
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.fetchExchangeRate()
                self?.startTimer()
            }.store(in: &cancellables)
    }
    
    private func startTimer() {
        timerCancellable?.cancel()
        timerCancellable = Timer
            .publish(every: Double(10), on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [weak self] _ in
                self?.fetchExchangeRate()
            })
    }
    
    private func fetchExchangeRate() {
        state.send(.isLoading)
        
        let request = ConversionRateRequest(amountStr: amount,
                                            sourceCurrency: sourceCurrency,
                                            targetCurrency: targetCurrency)
        exchangeCancellable = exchangeCurrencyUseCase
            .execute(with: request)
            .compactMap { $0?.amount }
            .receive(on: DispatchQueue.main)
            .catch { [weak self] error in
                self?.timerCancellable?.cancel()
                self?.state.send(.failed(error))
                return Just("ERROR")
            }
            .sink(receiveValue: { [weak self] in
                self?.state.send(.loaded($0))
            })
    }
}

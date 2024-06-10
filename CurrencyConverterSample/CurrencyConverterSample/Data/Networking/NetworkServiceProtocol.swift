//
//  NetworkServiceProtocol.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 02/06/2024.
//

import Combine

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: some Endpoint) -> AnyPublisher<T, NetworkError>
}

//
//  NetworkServiceProtocol.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 02/06/2024.
//

import Combine

protocol NetworkServiceProtocol {
    associatedtype EndpointType: Endpoint
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, NetworkError>
}

//
//  NetworkService.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 02/06/2024.
//

import Foundation
import Combine

final class NetworkService<EndpointType: Endpoint>: NetworkServiceProtocol {
    
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, NetworkError> {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { .init($0) }
            .eraseToAnyPublisher()
    }
}

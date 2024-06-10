//
//  NetworkService.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 02/06/2024.
//

import Foundation
import Combine

final class NetworkService: NetworkServiceProtocol {
    
    func request<T: Decodable>(_ endpoint: some Endpoint) -> AnyPublisher<T, Error> {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        debugPrint("Request URL: \(request.url?.absoluteString ?? "")")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { NetworkError($0) }
            .eraseToAnyPublisher()
    }
}

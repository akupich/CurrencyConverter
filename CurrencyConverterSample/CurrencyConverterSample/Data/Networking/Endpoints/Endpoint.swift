//
//  Endpoint.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 02/06/2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

extension Endpoint {
    var headers: [String: String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        return nil
    }
}

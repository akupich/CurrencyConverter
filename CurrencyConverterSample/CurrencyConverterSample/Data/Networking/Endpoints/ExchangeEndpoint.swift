//
//  ExchangeEndpoint.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 02/06/2024.
//

import Foundation

enum ExchangeEndpoint: Endpoint {
    case exchange(from: String, to: String, amount: Int)
    
    var baseURL: URL {
        return URL(string: "https://api.evp.lt/currency/commercial")!
    }
    
    var path: String {
        switch self {
        case .exchange(let from, let to, let amount):
            return "/exchange/\(amount)-\(from)/\(to)/latest"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .exchange:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .exchange:
            return ["Content-Type": "application/json"]
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .exchange:
            return nil
        }
    }
}

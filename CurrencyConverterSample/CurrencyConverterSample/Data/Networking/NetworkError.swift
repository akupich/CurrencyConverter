//
//  APIError.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 02/06/2024.
//

import Foundation

enum NetworkError: Error {
    case decodingFailed
    case noConnection
    case other(Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingFailed:
            return "Response data is incorrect"
        case .noConnection:
            return "Internet connection problem"
        case .other(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}

extension NetworkError {
    init(_ error: Error) {
        switch error {
        case is Swift.DecodingError:
          self = .decodingFailed
        case let urlError as URLError where urlError.errorCode == -1009:
            self = .noConnection
        default:
          self = .other(error)
        }
    }
}

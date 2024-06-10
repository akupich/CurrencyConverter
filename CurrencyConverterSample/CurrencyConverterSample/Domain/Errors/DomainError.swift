//
//  DomainError.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 10/06/2024.
//

import Foundation

enum DomainError: Error {
    case invalidArgument
}

extension DomainError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidArgument:
            return "Input data is incorrect"
        }
    }
}

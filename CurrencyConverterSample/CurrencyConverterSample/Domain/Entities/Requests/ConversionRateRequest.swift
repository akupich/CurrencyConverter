//
//  ConversionRateRequest.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 02/06/2024.
//

import Foundation

public struct ConversionRateRequest {
    public var amount: Double
    public var sourceCurrency: String
    public var targetCurrency: String
}

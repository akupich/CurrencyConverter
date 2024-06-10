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
    
    init?(amountStr: String?, sourceCurrency: Currency?, targetCurrency: Currency?) {
        guard let amountStr, let amount = Double(amountStr),
              let sourceCurrency = sourceCurrency?.rawValue,
              let targetCurrency = targetCurrency?.rawValue else { return nil }
        
        self.amount = amount
        self.sourceCurrency = sourceCurrency
        self.targetCurrency = targetCurrency
    }
}

//
//  SceneDelegate.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 02/06/2024.
//

import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo
               session: UISceneSession, options
               connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let exchangeRepository = ExchangeRepositoryImpl()
        let exchangeUseCase = ExchangeCurrencyUseCase(repository: exchangeRepository)
        let getAllCurrenciesRepository = GetAllCurrenciesRepositoryImpl()
        let availableCurrenciesUseCase = AvailableCurrenciesUseCase(repository: getAllCurrenciesRepository)
        
        let exchangeViewModel = ExchangeCurrencyViewModelImpl(exchangeCurrencyUseCase: exchangeUseCase,
                                                              availableCurrenciesUseCase: availableCurrenciesUseCase)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = CurrencyConverterViewController(viewModel: exchangeViewModel)
        window?.makeKeyAndVisible()
    }
}

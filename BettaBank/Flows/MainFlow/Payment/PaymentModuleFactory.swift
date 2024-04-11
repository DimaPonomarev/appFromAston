//
//  PaymentModuleFactory.swift
//  BettaBank
//
//  Created by Sofia Norina on 29.01.2024.
//

import UIKit

protocol FactoryProtocol {
    func makePaymentViewController() -> UIViewController
}

final class PaymentModuleFactory {}

extension PaymentModuleFactory: FactoryProtocol {
    
    func makePaymentViewController() -> UIViewController {
        let viewModel = PaymentViewModel()
        let viewController = PaymentViewController(viewModel: viewModel)
        return viewController
    }
}

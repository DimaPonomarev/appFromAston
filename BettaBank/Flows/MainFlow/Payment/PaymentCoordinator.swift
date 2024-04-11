//
//  Coordinator.swift
//  BettaBank
//
//  Created by Софья Норина on 29.11.2023.
//

import UIKit

final class PaymentCoordinator: TabCoordinator {
    
    var onStart: (() -> Void)?
    var onFinish: (() -> Void)?
    private let factory: FactoryProtocol
    
    init(coordinatorsFactory: CoordinatorsFactoryProtocol, router: Router, factory: PaymentModuleFactory) {
        self.factory = factory
        super.init(coordinatorsFactory: coordinatorsFactory, router: router)
    }

    func start() {
        onStart?()
        showViewController(viewController: factory.makePaymentViewController(), hidesBottomBar: false)
    }
}

extension PaymentCoordinator: CoordinatorOutput {
    func showViewController(viewController: UIViewController, hidesBottomBar: Bool) {
        viewController.hidesBottomBarWhenPushed = hidesBottomBar
        router.push(viewController)
    }
}

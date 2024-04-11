//
//  ProductCoordinator.swift
//  BettaBank
//
//  Created by Sofia Norina on 28.01.2024.
//

import UIKit

final class ProductCoordinator: TabCoordinator {
    
    var onStart: (() -> Void)?
    var onFinish: (() -> Void)?
    private let factory: ProductModuleFactoryProtocol
    
    init(coordinatorsFactory: CoordinatorsFactoryProtocol, router: Router, factory: ProductModuleFactory) {
        self.factory = factory
        super.init(coordinatorsFactory: coordinatorsFactory, router: router)
    }
    
    func start() {
        onStart?()
        showViewController(viewController: factory.makeViewController(type: .products(self)), hidesBottomBar: false)
    }
}

extension ProductCoordinator: CoordinatorOutput {
    func showViewController(viewController: UIViewController, hidesBottomBar: Bool) {
        viewController.hidesBottomBarWhenPushed = hidesBottomBar
        router.push(viewController)
    }
}

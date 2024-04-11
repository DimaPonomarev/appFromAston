//
//  MoreCoordinator.swift
//  BettaBank
//
//  Created by Sofia Norina on 28.01.2024.
//

import UIKit

final class MoreCoordinator: TabCoordinator {
    
    var onStart: (() -> Void)?
    var onFinish: (() -> Void)?
    private let factory: MoreTabFactoryProtocol
    
    init(coordinatorsFactory: CoordinatorsFactoryProtocol, router: Router, factory: MoreTabFactoryProtocol) {
        self.factory = factory
        super.init(coordinatorsFactory: coordinatorsFactory, router: router)
    }
    
    func start() {
        onStart?()
        showViewController(viewController: factory.makeViewController(type: .more(self)), hidesBottomBar: false)
    }
    
    func closeDemo() {
        finish()
    }
}

extension MoreCoordinator: CoordinatorOutput {
    func showViewController(viewController: UIViewController, hidesBottomBar: Bool) {
        viewController.hidesBottomBarWhenPushed = hidesBottomBar
        router.push(viewController)
    }
}

//
//  CoordinatorsFactory.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 14.12.2023.
//

import UIKit

protocol CoordinatorsFactoryProtocol {
    func makeAppCoordinator(rootNavigationController: UINavigationController) -> Coordinator
    func makeLoginCoordinator(parent: Coordinator, onFinish: @escaping () -> Void) -> Coordinator
    func makeTabBarCoordinator(parent: Coordinator, onFinish: @escaping () -> Void) -> Coordinator
    func makeMainPageCoordinator(parent: Coordinator, router: Router) -> Coordinator
    func makePaymentCoordinator(parent: Coordinator, router: Router) -> Coordinator
    func makeProductsCoordinator(parent: Coordinator, router: Router) -> Coordinator
    func makeStoryCoordinator(parent: Coordinator, router: Router) -> Coordinator
    func makeMoreTabCoordinator(parent: Coordinator, router: Router, onFinish: @escaping () -> Void) -> Coordinator
    func makeCardInfoCoordinator(parent: Coordinator) -> Coordinator
}

final class CoordinatorsFactory: CoordinatorsFactoryProtocol {
    func makeAppCoordinator(rootNavigationController: UINavigationController) -> Coordinator {
        let router = Router(navigationController: rootNavigationController)
        let coordinator = AppCoordinator(coordinatorsFactory: self, router: router)
        
        return coordinator
    }
    
    func makeLoginCoordinator(parent: Coordinator, onFinish: @escaping () -> Void) -> Coordinator {
        let loginCoordinator: Coordinator = LoginCoordinator(coordinatorsFactory: self, router: parent.router)
        configure(coordinator: loginCoordinator, parent: parent, onFinish: onFinish)
        
        return loginCoordinator
    }
    
    func makeTabBarCoordinator(parent: Coordinator, onFinish: @escaping () -> Void) -> Coordinator {
        let tabBarCoordinator: Coordinator = TabBarCoordinator(coordinatorsFactory: self, router: parent.router)
        configure(coordinator: tabBarCoordinator, parent: parent, onFinish: onFinish)
        
        return tabBarCoordinator
    }

    func makeMainPageCoordinator(parent: Coordinator, router: Router) -> Coordinator {
        let mainPageCoordinator: TabCoordinator = MainPageCoordinator(coordinatorsFactory: self, router: router)
        let tabBar = TabBarItemModel(
            activeIcon: .activeMainPageIcon,
            inactiveIcon: .inactiveMainPageIcon,
            title: TabBarTitles.mainPage
        )
        
        configure(coordinator: mainPageCoordinator, parent: parent) { }
        mainPageCoordinator.setTab(coordinator: mainPageCoordinator, model: tabBar)
        
        return mainPageCoordinator
    }
    
    func makePaymentCoordinator(parent: Coordinator, router: Router) -> Coordinator {
        let paymentCoordinator: TabCoordinator = PaymentCoordinator(coordinatorsFactory: self, router: router, factory: PaymentModuleFactory())
        let tabBar = TabBarItemModel(
            activeIcon: .activePaymentIcon,
            inactiveIcon: .inactivePaymentIcon,
            title: TabBarTitles.payment
        )

        configure(coordinator: paymentCoordinator, parent: parent) { }
        paymentCoordinator.setTab(coordinator: paymentCoordinator, model: tabBar)
        
        return paymentCoordinator
    }
    
    func makeProductsCoordinator(parent: Coordinator, router: Router) -> Coordinator {
        let productsCoordinator: TabCoordinator = ProductCoordinator(coordinatorsFactory: self, router: router, factory: ProductModuleFactory())
        let tabBar = TabBarItemModel(
            activeIcon: .activeProductIcon,
            inactiveIcon: .inactiveProductIcon,
            title: TabBarTitles.products
        )
        
        configure(coordinator: productsCoordinator, parent: parent) { }
        productsCoordinator.setTab(coordinator: productsCoordinator, model: tabBar)

        return productsCoordinator
    }
    
    func makeStoryCoordinator(parent: Coordinator, router: Router) -> Coordinator {
        let historyCoordinator: TabCoordinator = HistoryCoordinator(coordinatorsFactory: self, router: router)
        let tabBar = TabBarItemModel(
            activeIcon: .inactiveStoryIcon,
            inactiveIcon: .inactiveStoryIcon,
            title: TabBarTitles.history
        )
        
        configure(coordinator: historyCoordinator, parent: parent) { }
        historyCoordinator.setTab(coordinator: historyCoordinator, model: tabBar)

        return historyCoordinator
    }
    
    func makeMoreTabCoordinator(parent: Coordinator, router: Router, onFinish: @escaping () -> Void) -> Coordinator {
        let moreTabCoordinator: TabCoordinator = MoreCoordinator(coordinatorsFactory: CoordinatorsFactory(),
                                                                 router: router, factory: MoreModuleFactory())
        let tabBar = TabBarItemModel(
            activeIcon: .activeMoreIcon,
            inactiveIcon: .inactiveMoreIcon,
            title: TabBarTitles.moreTab
        )

        configure(coordinator: moreTabCoordinator, parent: parent, onFinish: onFinish)
        moreTabCoordinator.setTab(coordinator: moreTabCoordinator, model: tabBar)

        return moreTabCoordinator
    }
    
    func makeCardInfoCoordinator(parent: Coordinator) -> Coordinator {
        let cardInfoCoordinator = CardInfoCoordinator(coordinatorsFactory: self, router: parent.router)
        
        return cardInfoCoordinator
    }
    
    private func configure(coordinator: Coordinator, parent: Coordinator, onFinish: @escaping () -> Void) {
        coordinator.onFinish = { [weak coordinator] in
            guard let coordinator else {
                return
            }
            
            parent.removeDependency(coordinator)
            onFinish()
        }
        
        parent.addDependency(coordinator)
    }
}

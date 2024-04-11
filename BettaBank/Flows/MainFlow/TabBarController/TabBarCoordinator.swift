//
//  TabBarCoordinator.swift
//  BettaBank
//
//  Created by Egor Kruglov on 08.11.2023.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    var onStart: (() -> Void)?
    var onFinish: (() -> Void)?
    
    private lazy var tabBarViewController = getTabBarViewController()
    
    deinit {
        print(String(describing: Self.self) + " was deinited")
    }
    
    func start() {
        onStart?()
        setTabBar()
        showMainPage()
        showProducts()
        showPayment()
        showHistory()
        showMore()
    }
    
    private func setTabBar() {
        router.setViewControllers([tabBarViewController], isNavigationBarHidden: true)
    }
    
    private func showMainPage() {
        let mainPageNavigationController = UINavigationController()
        let mainPageRouter = Router(navigationController: mainPageNavigationController)
        let mainPageCoordinator = coordinatorsFactory.makeMainPageCoordinator(parent: self, router: mainPageRouter)
        mainPageCoordinator.start()
        
        tabBarViewController.viewControllers = [mainPageNavigationController]
    }
    
    private func showProducts() {
        let productsNavigationController = UINavigationController()
        let productsRouter = Router(navigationController: productsNavigationController)
        let productsCoordinator = coordinatorsFactory.makeProductsCoordinator(parent: self, router: productsRouter)
        productsCoordinator.start()
        
        tabBarViewController.viewControllers?.append(productsNavigationController)
    }
    
    private func showPayment() {
        let paymentNavigationController = UINavigationController()
        let paymentRouter = Router(navigationController: paymentNavigationController)
        let paymentCoordinator = coordinatorsFactory.makePaymentCoordinator(parent: self, router: paymentRouter)
        paymentCoordinator.start()
        
        tabBarViewController.viewControllers?.append(paymentNavigationController)
    }
    
    private func showHistory() {
        let historyNavigationController = UINavigationController()
        let historyRouter = Router(navigationController: historyNavigationController)
        let historyCoordinator = coordinatorsFactory.makeStoryCoordinator(parent: self, router: historyRouter)
        historyCoordinator.start()
        
        tabBarViewController.viewControllers?.append(historyNavigationController)
    }
    
    private func showMore() {
        let moreTabNavigationController = UINavigationController()
        let moreTabRouter = Router(navigationController: moreTabNavigationController)
        let moreCoordinator = coordinatorsFactory.makeMoreTabCoordinator(
            parent: self,
            router: moreTabRouter,
            onFinish: { [weak self] in
                self?.finish()
            }
        )
        
        moreCoordinator.start()
        
        tabBarViewController.viewControllers?.append(moreTabNavigationController)
    }
}

private extension TabBarCoordinator {
    func getTabBarViewController() -> TabBarViewController {
        let tabBarViewModel = TabBarViewModel(coordinator: self)
        let tabBarViewController = TabBarViewController(viewModel: tabBarViewModel)
        
        return tabBarViewController
    }
}

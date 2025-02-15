//
//  Router.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 05.11.2023.
//

import UIKit

final class Router {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setTabBarItem(_ tabBarItem: UITabBarItem) {
        navigationController.tabBarItem = tabBarItem
    }
    
    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool = true) {        
        navigationController.popToRootViewController(animated: animated)
    }
    
    func present(
        _ viewController: UIViewController,
        animated: Bool = true,
        presentationStyle: UIModalPresentationStyle = .automatic
    ) {
        viewController.modalPresentationStyle = presentationStyle
        navigationController.present(viewController, animated: animated)
    }
    
    func dismiss(_ viewController: UIViewController, animated: Bool = true) {
        viewController.dismiss(animated: animated)
    }
    
    func setViewControllers(_ viewControllers: [UIViewController], isNavigationBarHidden: Bool = false) {
        navigationController.setViewControllers(viewControllers, animated: false)
        navigationController.setNavigationBarHidden(isNavigationBarHidden, animated: false)
    }
}

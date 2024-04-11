//
//  AppCoordinator.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 05.11.2023.
//

import UIKit

protocol WelcomeScreenOutput: AnyObject {
    func showLogin()
    func showMainFlow()
}

protocol SplashScreenOutput: AnyObject {
    func showWelcomeScreen()
    func showServerError()
}

final class AppCoordinator: Coordinator {    
    var onStart: (() -> Void)?
    
    func start() {
        let splashViewModel = SplashViewModel(output: self)
        let splashViewController = SplashViewController(splashViewModel: splashViewModel)
        
        router.setViewControllers([splashViewController])
        
        onStart?()
    }
    
    private func showWelcomeViewController() {
        let welcomeViewModel = WelcomeScreenViewModel()
        welcomeViewModel.output = self
        
        let welcomeViewController = WelcomeViewController(welcomeViewModel: welcomeViewModel)
        
        router.setViewControllers([welcomeViewController])
    }
}

extension AppCoordinator: WelcomeScreenOutput {
    func showLogin() {
        let loginViewController = coordinatorsFactory.makeLoginCoordinator(parent: self) { [weak self] in
            self?.showWelcomeViewController()
        }
        
        loginViewController.start()
    }
    
    func showMainFlow() {
        let tabBarCoordinator = coordinatorsFactory.makeTabBarCoordinator(parent: self) { [weak self] in
            self?.showWelcomeViewController()
        }
        
        tabBarCoordinator.start()
    }
}

extension AppCoordinator: SplashScreenOutput {
    func showWelcomeScreen() {
        showWelcomeViewController()
    }
    
    func showServerError() {
        let serverErrorViewController = ServerErrorViewController()
        
        router.push(serverErrorViewController)
    }
}

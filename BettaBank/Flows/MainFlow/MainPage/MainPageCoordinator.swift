//
//  MainPageCoordinator.swift
//  BettaBank
//
//  Created by Egor Kruglov on 27.11.2023.
//

import Foundation
import UIKit

protocol MainPageOutput {
    func goToProfileViewController()
    func goToNotifications()
    func goToAppPasswordChanging()
    func goToMainPage()
    func goToCardInfoDescriptionPage(_ model: CardData)
    func goToChooseNewCard()
    func goToDepositAccontPage()
    func goToLoanPage()
    func goToDepositPage(with model: DepositFullInfoModel)
    func goToAccountPage(with model: AccountFullInfoModel)
    func goToChangeAppPasswordScreen()
    func goToWasChangeAppPasswordScreen()
}

protocol PersonalAccountOutput {
    func goToChangePasswordScreen()
    func goToNotificationSettingsScreen()
    func goToMainPage()
}

protocol NotificationSettingsOutput {
    func goToChangeEmailScreen()
}

protocol AppPasswordDidChangedOutput {
    func goToMainPage()
}

protocol LoanPageOutput {
    func dismissLoan(viewController: UIViewController)
    func goToFullInfoLoanVC(with model: LoanFullInfoModel)
}

final class MainPageCoordinator: TabCoordinator {
    var onStart: (() -> Void)?
    
    func start() {
        onStart?()
        showMainPageScreen()
    }
    
    private func showMainPageScreen() {
        let mainPageViewController = getMainPageViewController()
        router.setViewControllers([mainPageViewController])
    }
    
    private func getMainPageViewController() -> UIViewController {
        let mainPageViewModel = MainPageViewModel(output: self)
        let mainPageViewController = MainPageViewController(viewModel: mainPageViewModel)
        return mainPageViewController
    }
}

extension MainPageCoordinator: MainPageOutput {
    
    func goToCardInfoDescriptionPage(_ model: CardData) {
        let cardInfoCoordinator = coordinatorsFactory.makeCardInfoCoordinator(parent: self)
        cardInfoCoordinator.start()
    }
    
    func goToChooseNewCard() {
        let networkService = NetworkService()
        let viewModel = ChooseNewCardViewModel(output: self, network: networkService)
        let viewController = ChooseNewCardViewController(viewModel: viewModel)
        let navigationViewController = UINavigationController(rootViewController: viewController)
        
        router.present(navigationViewController, presentationStyle: .fullScreen)
    }
    
    func goToProfileViewController() {
        let viewModel = PersonalAccountViewModel(coordinator: self)
        let viewController = PersonalAccountViewController(viewModel: viewModel)
        viewController.hidesBottomBarWhenPushed = true
        
        router.push(viewController)
    }
    
    func goToNotifications() {
        let dataSource = NotificationDataSource()
        let viewController = NotificationsViewController(notificationDataSource: dataSource)
        let navigationViewController = UINavigationController(rootViewController: viewController)
        
        router.present(navigationViewController, presentationStyle: .fullScreen)
    }
    
    func goToAppPasswordChanging() {
        let viewModel = ChangingAppPasswordViewModel(coordinator: self)
        let viewController = ChangingAppPasswordViewController(viewModel: viewModel)
        viewController.hidesBottomBarWhenPushed = true
        
        router.push(viewController)
    }
    
    func goToDepositAccontPage() {
        let depositAndAccountViewController = DepositAndAccountViewController(viewModel: DepositAndAccountViewModel(coordinator: self))
        depositAndAccountViewController.hidesBottomBarWhenPushed = true
        
        router.push(depositAndAccountViewController)
    }
    
    func goToLoanPage() {
        let viewModel = LoansViewModel(output: self)
        let viewController = LoansViewController(viewModel: viewModel)
        viewController.hidesBottomBarWhenPushed = true
        
        router.push(viewController)
    }
    
    func goToDepositPage(with model: DepositFullInfoModel) {
        let viewModel = DepositViewModel()
        let viewController = DepositViewController(viewModel: viewModel, model: model)
        
        router.push(viewController, animated: true)
    }
    
    func goToAccountPage(with model: AccountFullInfoModel) {
        let viewModel = AccountViewModel(model: model)
        let viewController = AccountViewController(viewModel: viewModel)
        
        router.push(viewController, animated: true)
    }
}

extension MainPageCoordinator: LoanPageOutput {
    func goToFullInfoLoanVC(with model: LoanFullInfoModel) {
        let viewModel = LoansViewModel(output: self)
        let viewController = FullInfoLoanViewController(viewModel: viewModel, loanModel: model)
        
        router.push(viewController, animated: true)
    }
    
    func dismissLoan(viewController: UIViewController) {
        router.dismiss(viewController)
    }
}

extension MainPageCoordinator: PersonalAccountOutput {
    
    func goToChangePasswordScreen() {
        let viewModel = ChangingAppPasswordViewModel(coordinator: self)
        let viewController = ChangingAppPasswordViewController(viewModel: viewModel)
        
        router.push(viewController)
    }
    
    func goToNotificationSettingsScreen() {
        let viewModel = NotificationSettingsViewModel(coordinator: self)
        let viewController = NotificationSettingsViewController(viewModel: viewModel)
        
        router.push(viewController)
    }
}

extension MainPageCoordinator: NotificationSettingsOutput {
    func goToChangeEmailScreen() {
        let viewModel = ChangeEmailViewModel(coordinator: self)
        let viewController = ChangeEmailViewController(viewModel: viewModel)
        
        router.push(viewController)
    }
    
    func goToChangeAppPasswordScreen() {
        let viewModel = ChangingAppPasswordViewModel(coordinator: self)
        let viewController = ChangingAppPasswordViewController(viewModel: viewModel)
        
        router.push(viewController)
    }
    
    func goToWasChangeAppPasswordScreen() {
        let viewModel = AppPasswordWasChangedViewModel(coordinator: self)
        let viewController = AppPasswordWasChangedViewController(viewModel: viewModel)
        
        router.push(viewController)
    }
}

extension MainPageCoordinator: AppPasswordDidChangedOutput {
    func goToMainPage() {
        
        router.pop()
    }
}

//
//  CardInfoCoordinator.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 18.12.2023.
//

import UIKit

protocol CardInfoOutput: AnyObject {
    
    func goToCardDetailsPage()
    func goToPinCodeSetupPage()
    func showPinCodeChangedViewController()
}

final class CardInfoCoordinator: Coordinator {
    var onStart: (() -> Void)?
    
    func start() {
        showCardInfo()
        onStart?()
    }
        
    private func showCardInfo() {
        let viewController = getDemoChosenCardInfoViewController()
        router.push(viewController)
    }
    
    private func getDemoChosenCardInfoViewController() -> UIViewController {
        let viewModel = ChosenCardInfoViewModel(output: self)
        let viewController = ChosenCardInfoViewController(viewModel: viewModel)
        return viewController
    }
}

extension CardInfoCoordinator: CardInfoOutput {
    func goToCardDetailsPage() {
        let viewModel = CardDetailsViewModel(output: self)
        let viewController = CardDetailsViewController(viewModel: viewModel)
        
        router.push(viewController)
    }
    
    func goToPinCodeSetupPage() {
        let viewModel = PinCodeSetupViewModel(output: self)
        let viewController = PinCodeSetupViewController(viewModel: viewModel)
        
        router.push(viewController)
    }
    
    func showPinCodeChangedViewController() {
        let pinCodeChangedViewController = PinCodeChangedViewController()
        
        router.push(pinCodeChangedViewController)
    }

}

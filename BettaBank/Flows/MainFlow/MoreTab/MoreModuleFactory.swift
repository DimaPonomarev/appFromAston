//
//  MoreModuleFactory.swift
//  BettaBank
//
//  Created by Sofia Norina on 25.01.2024.
//

import UIKit

enum MoreViewControllerType {
    case contacts
    case location
    case termsOfUse
    case privacyPolicy
    case dataStorage
    case more(CoordinatorOutput)
}

protocol MoreTabFactoryProtocol {
    func makeViewController(type: MoreViewControllerType) -> UIViewController
}

final class MoreModuleFactory: MoreTabFactoryProtocol {
    
    func makeViewController(type: MoreViewControllerType) -> UIViewController {
        switch type {
        case .contacts:
            return ContactsViewController()
        case .location:
            return BankAddressesViewController()
        case .termsOfUse:
            return UserAgreementsViewController(userAgreementsType: .termsOfUse)
        case .privacyPolicy:
            return UserAgreementsViewController(userAgreementsType: .privacyPolicy)
        case .dataStorage:
            return UserAgreementsViewController(userAgreementsType: .dataStorage)
        case .more(let output):
            let viewModel = MoreTabViewModel(output: output, factory: self)
            return MoreTabViewController(viewModel: viewModel)
        }
    }
}

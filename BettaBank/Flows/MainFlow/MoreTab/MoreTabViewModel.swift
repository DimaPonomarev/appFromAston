//
//  DemoMoreTabViewModel.swift
//  BettaBank
//
//  Created by Vadim Blagodarny on 05.12.2023.
//

import Foundation

protocol MoreTabViewModelProtocol: AnyObject {
    func showContactsTapped()
    func showLocationTapped()
    func exitButtonTapped()
    func dataStorageButtonTapped()
    func privacyPolicyButtonTapped()
    func termOfUseButtonTapped()
}

final class MoreTabViewModel: MoreTabViewModelProtocol {
    
    // MARK: - external properties
    
    private let output: CoordinatorOutput
    private let factory: MoreTabFactoryProtocol
    
    // MARK: - init
    
    init(output: CoordinatorOutput, factory: MoreTabFactoryProtocol) {
        self.output = output
        self.factory = factory
        
    }
    
    // MARK: - delegate methods
    
    func showContactsTapped() {
        let viewController = factory.makeViewController(type: .contacts)
        output.showViewController(viewController: viewController, hidesBottomBar: true)
    }
    
    func exitButtonTapped() {
        output.closeDemo()
    }
    
    func dataStorageButtonTapped() {
        let viewController = factory.makeViewController(type: .dataStorage)
        output.showViewController(viewController: viewController, hidesBottomBar: true)
    }
    
    func privacyPolicyButtonTapped() {
        let viewController = factory.makeViewController(type: .privacyPolicy)
        output.showViewController(viewController: viewController, hidesBottomBar: true)
    }
    
    func termOfUseButtonTapped() {
        let viewController = factory.makeViewController(type: .termsOfUse)
        output.showViewController(viewController: viewController, hidesBottomBar: true)
    }
    
    func showLocationTapped() {
        let viewController = factory.makeViewController(type: .location)
        output.showViewController(viewController: viewController, hidesBottomBar: true)
    }
}

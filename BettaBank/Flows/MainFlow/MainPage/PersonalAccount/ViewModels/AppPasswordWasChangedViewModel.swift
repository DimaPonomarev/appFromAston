//
//  AppPasswordWasChangedViewModel.swift
//  BettaBank
//
//  Created by Борис Кравченко on 21.12.2023.
//

import Foundation

protocol AppPasswordWasChangedViewModelProtocol: AnyObject {
    func toMainDidTapped()
}

final class AppPasswordWasChangedViewModel: AppPasswordWasChangedViewModelProtocol {
    
    func toMainDidTapped() {
        coordinator.goToMainPage()
    }
    
    //  MARK: - External properties
    
    private let coordinator: AppPasswordDidChangedOutput
    
    //  MARK: Data Variables
    
    // MARK: Private Variables
    
    //  MARK: - Init
    
    init(coordinator: AppPasswordDidChangedOutput) {
        self.coordinator = coordinator
    }
    
    //  MARK: - Delegate methodes
    
    //  MARK: - Private Methods
    
}

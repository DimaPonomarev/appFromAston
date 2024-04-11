//
//  ChangeEmailViewModelViewModel.swift
//  BettaBank
//
//  Created by Dzhami on 14.12.2023.
//

import Foundation

protocol ChangeEmailViewModelProtocol: AnyObject {
    
}

final class ChangeEmailViewModel: ChangeEmailViewModelProtocol {
    
    //  MARK: - External properties
    
    private let coordinator: NotificationSettingsOutput
    
    //  MARK: Data Variables
    
    // MARK: Private Variables
    
    //  MARK: - Init
    
    init(coordinator: NotificationSettingsOutput) {
        self.coordinator = coordinator
    }
    
    //  MARK: - Delegate methodes
    
    //  MARK: - Private Methods
    
}

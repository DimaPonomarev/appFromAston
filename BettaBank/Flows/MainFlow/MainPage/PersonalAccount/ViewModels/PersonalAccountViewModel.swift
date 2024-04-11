//
//  DemoPersonalAccauntViewModel.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 29.11.2023.
//

import Foundation

protocol PersonalAccountViewModelProtocol {
    func notificationViewDidTapped()
    func changePasswordViewDidTapped()
}

final class PersonalAccountViewModel: PersonalAccountViewModelProtocol {
    
    private let coordinator: PersonalAccountOutput
    
    //  MARK: - Init
    
    init(coordinator: PersonalAccountOutput) {
        self.coordinator = coordinator
    }
       
    func notificationViewDidTapped() {
        coordinator.goToNotificationSettingsScreen()
    }
    
    func changePasswordViewDidTapped() {
        coordinator.goToChangePasswordScreen()
    }
}

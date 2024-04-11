//
//  NotificationsSettingsViewModel.swift
//  BettaBank
//
//  Created by Dzhami on 13.12.2023.
//

import Foundation
import UIKit

protocol NotificationSettingsViewModelProtocol {
    func emailDidTapped()
}

final class NotificationSettingsViewModel: NotificationSettingsViewModelProtocol {
    
    private let coordinator: NotificationSettingsOutput

    //  MARK: - Init
    
    init(coordinator: NotificationSettingsOutput) {
        self.coordinator = coordinator
    }
    
    func emailDidTapped() {
        coordinator.goToChangeEmailScreen()
    }
}

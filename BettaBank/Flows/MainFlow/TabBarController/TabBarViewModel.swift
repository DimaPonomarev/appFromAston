//
//  TabBarViewModel.swift
//  BettaBank
//
//  Created by Egor Kruglov on 08.11.2023.
//

import Foundation

protocol TabBarViewModelProtocol {
    func didTapExitDemoButton()
}

final class TabBarViewModel: TabBarViewModelProtocol {
    
    private var coordinator: TabBarCoordinator
    
    init(coordinator: TabBarCoordinator) {
        self.coordinator = coordinator
    }
    
    deinit {
        print(String(describing: Self.self) + " was deinited")
    }
    
    func didTapExitDemoButton() {
        coordinator.finish()
    }
}

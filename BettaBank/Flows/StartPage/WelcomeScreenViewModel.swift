//
//  WelcomeScreenViewModel.swift
//  MRN Coordinator
//
//  Created by Margarita Slesareva on 06.11.2023.
//

final class WelcomeScreenViewModel {
    
    var output: WelcomeScreenOutput?
    
    func loginButtonTapped() {
        output?.showLogin()
    }
    
    func demoButtonTapped() {
        output?.showMainFlow()
    }
}

//
//  SplashViewModel.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 26.11.2023.
//

import Foundation

protocol SplashViewModelProtocol: AnyObject {
    func animatedLoader()
}

final class SplashViewModel: SplashViewModelProtocol {
    
    //  MARK: - External properties
    private let output: SplashScreenOutput
    
    // MARK: Private Variables
    private let requestIsValid = true

    //  MARK: - Init
    init(output: SplashScreenOutput) {
        self.output = output
    }
    
    //  MARK: - Delegate methodes
    func animatedLoader() {
        if requestIsValid {
            output.showWelcomeScreen()
        } else {
            output.showServerError()
        }
    }
}

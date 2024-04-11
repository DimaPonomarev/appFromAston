//
//  CreatingPasswordViewModel.swift
//  BettaBank
//
//  Created by Dmitry Gorbunow on 11/6/23.
//

import Foundation

protocol CreatingPasswordViewModelProtocol {
    var password: String { get set }
    var secondPassword: String { get set }
    var isPasswordMatching: Bool { get }
    var isLengthValid: Bool { get }
    var isLowerUpperValid: Bool { get }
    var isNumberValid: Bool { get }
    var isSpecialCharacterValid: Bool { get }
    var eventType: AuthenticationType? { get set }
    var recoveryType: RecoveryType? { get set }
    func showProfile()
    func goToLogin()
}

final class CreatingPasswordViewModel: CreatingPasswordViewModelProtocol {

    // MARK: - Properties
    
    var eventType: AuthenticationType?
    var recoveryType: RecoveryType?

    // MARK: - Properties
    
    private let output: CreatePasswordOutput
    var password: String = "" {
        didSet {
            validatePassword()
        }
    }
    
    init(output: CreatePasswordOutput) {
        self.output = output
    }
    
    var secondPassword: String = "" {
        didSet {
            passwordMatching()
        }
    }
    
    var isPasswordMatching: Bool = false
    var isLengthValid: Bool = false
    var isLowerUpperValid: Bool = false
    var isNumberValid: Bool = false
    var isSpecialCharacterValid: Bool = false

    // MARK: - Private Methods

    private func validatePassword() {
        isLengthValid = Validator.isValidPasswordLength(for: password)
        isLowerUpperValid = Validator.isValidPasswordLowercaseUppercase(for: password)
        isNumberValid = Validator.isValidPasswordNumbers(for: password)
        isSpecialCharacterValid = Validator.isValidPasswordSpecialCharacters(for: password)
    }
    
    private func passwordMatching() {
        if password == secondPassword && isLengthValid && isLowerUpperValid && isNumberValid && isSpecialCharacterValid {
            isPasswordMatching = true
        }
    }

    // MARK: - Public Methods

    func goToLogin() {
        output.showLogin()
    }
    
    func showProfile() {
        output.showProfile()
    }
}

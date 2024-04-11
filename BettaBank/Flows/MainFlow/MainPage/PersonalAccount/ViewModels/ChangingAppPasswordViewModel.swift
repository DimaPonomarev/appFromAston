//
//  ChangingAppPasswordViewModel.swift
//  BettaBank
//
//  Created by Борис Кравченко on 16.12.2023.
//

import Foundation

protocol ChangingAppPasswordViewModelProtocol {
    var oldPassword: String { get set }
    var newPassword: String { get set }
    var repeatPassword: String { get set }
    var isLengthValid: Bool { get }
    var isNumberValid: Bool { get }
    var isOldPasswordValid: Bool { get }
    var isPasswordMatching: Bool { get }
    var passwordChangeCompletion: (() -> Void)? { get set }
    func performPasswordChange()
    func changeDidTapped()
    }

class ChangingAppPasswordViewModel: ChangingAppPasswordViewModelProtocol {

    private let coordinator: MainPageOutput
    
    var oldPassword: String = "" {
        didSet {
            validateOldPassword()
        }
    }
    
    var newPassword: String = "" {
        didSet {
            validatePasswordChange()
        }
    }
    
    var repeatPassword: String = "" {
        didSet {
            validatePasswordChange()
        }
    }
    
    var isOldPasswordValid: Bool = false
    var isLengthValid: Bool = false
    var isNumberValid: Bool = false
    var isPasswordMatching: Bool = false
    var passwordChangeCompletion: (() -> Void)?
    
    init(coordinator: MainPageOutput) {
        self.coordinator = coordinator
    }
    
    func changeDidTapped() {
        coordinator.goToWasChangeAppPasswordScreen()
    }
    
    private func validateOldPassword() {
        isOldPasswordValid = Validator.isOldPasswordValid(for: oldPassword)
    }
    
    private func validatePasswordChange() {
        isLengthValid = Validator.isValidAppPasswordLength(for: newPassword)
        isNumberValid = Validator.isValidPasswordNumbers(for: newPassword)
        isPasswordMatching = newPassword == repeatPassword && isLengthValid && isNumberValid
    }
    
    func performPasswordChange() {
        if isPasswordMatching && isOldPasswordValid {
            passwordChangeCompletion?()
        }
    }
}

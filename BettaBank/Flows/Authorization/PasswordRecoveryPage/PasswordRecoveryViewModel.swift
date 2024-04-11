//
//  PasswordRecoveryViewModel.swift
//  BettaBank
//
//  Created by Dzhami Rakhmetov on 11/13/23.
//

import Foundation

protocol PasswordRecoveryViewModelProtocol {
    var isPhoneNumberValid: Bool { get }
    var isEmailValid: Bool { get }
    var phoneNumber: String { get set }
    var email: String { get set }
    func nextButtonTapped()
}

// MARK: - Constants

private enum Constants {
    static let phoneNumberMaxLength: Int = 16
    static let documentMinLength: Int = 1
}

final class PasswordRecoveryViewModel: PasswordRecoveryViewModelProtocol {

    // MARK: - Properties

    private let output: PasswordRecoveryOutput
    private let recoveryType: RecoveryType
    
    var phoneNumber: String = "" {
        didSet {
            validatePhoneNumber()
        }
    }
    
    var email: String = "" {
        didSet {
            validateEmail()
        }
    }
    
    var isPhoneNumberValid: Bool = false
    var isEmailValid: Bool = false

    // MARK: - init
    
    init(output: PasswordRecoveryOutput, recoveryType: RecoveryType) {
        self.output = output
        self.recoveryType = recoveryType
    }
        
    func nextButtonTapped() {
        switch recoveryType {
        case .phoneNumber:
            if isPhoneNumberValid {
                goToEnterCodeFromSms()
            }
        case .email:
            if isEmailValid {
                goToCreatingPassword()
            }
        }
    }
    
    private func validatePhoneNumber() {
        isPhoneNumberValid = phoneNumber.count == Constants.phoneNumberMaxLength
    }
    
    private func validateEmail() {
        isEmailValid = email.count > Constants.documentMinLength
    }
    
    private func goToEnterCodeFromSms() {
        output.showEnterCodeFromSms(eventType: .restorePassword)
    }
    
    private func goToCreatingPassword() {
        output.showCreatingPassword(eventType: .restorePassword, recovery: recoveryType)
    }
}

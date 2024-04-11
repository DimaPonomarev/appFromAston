//
//  RegistrationViewModel.swift
//  BettaBank
//
//  Created by Dmitry Gorbunow on 11/3/23.
//

import Foundation

// MARK: - Constants

private enum Constants {
    static let phoneNumberMaxLength: Int = 16
    static let documentMinLength: Int = 1
}

protocol RegistrationViewModelProtocol {
    var phoneNumber: String { get set }
    var document: String { get set }
    var email: String { get set }
    var isPhoneNumberValid: Bool { get }
    var isDocumentValid: Bool { get }
    var isEmailValid: Bool { get }
    func goToEnterCodeFromSms()
    func goToCreatingPassword()
    func goToPrivacyPolicy(userAgreementsType: UserAgreementsType)
    func goToLogin()
    func goToProfile()
}

final class RegistrationViewModel: RegistrationViewModelProtocol {

    var phoneNumber: String = "" {
        didSet {
            validatePhoneNumber()
        }
    }
    
    var document: String = "" {
        didSet {
            validateDocument()
        }
    }
    
    var email: String = "" {
        didSet {
            validateEmail()
        }
    }
    
    var isPhoneNumberValid: Bool = false
    var isDocumentValid: Bool = false
    var isEmailValid: Bool = false

    // MARK: - Properties
    
    private let output: RegistrationScreenOutput

    // MARK: - init
    
    init(output: RegistrationScreenOutput) {
        self.output = output
    }

    // MARK: - Private Methods
    
    private func validatePhoneNumber() {
        isPhoneNumberValid = phoneNumber.count == Constants.phoneNumberMaxLength
    }
    
    private func validateDocument() {
        isDocumentValid = document.count > Constants.documentMinLength
    }
    
    private func validateEmail() {
        isEmailValid = Validator.isValidEmail(email)
    }

    // MARK: - Public Methods
    
    func goToEnterCodeFromSms() {
        output.showEnterCodeFromSms(eventType: .registration)
    }
    
    func goToCreatingPassword() {
        output.showCreatingPassword(eventType: .registration)
    }
    
    func goToPrivacyPolicy(userAgreementsType: UserAgreementsType) {
        output.showPrivacyPolicy(userAgreementsType: userAgreementsType)
    }
    
    func goToLogin() {
        output.showLogin()
    }
    
    func goToProfile() {
        output.showProfile()
    }
}

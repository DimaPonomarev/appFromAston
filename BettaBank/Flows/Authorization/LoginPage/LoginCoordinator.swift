//
//  LoginCoordinator.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 14.11.2023.
//
import UIKit

enum AuthenticationType {
    case registration
    case restorePassword
}

enum RecoveryType {
    case phoneNumber
    case email
}

protocol LoginOutput {
    func showPasswordRecovery(recoveryType: RecoveryType)
    func showRegistration()
    func showProfile()
}

protocol RegistrationScreenOutput {
    func showEnterCodeFromSms(eventType: AuthenticationType)
    func showCreatingPassword(eventType: AuthenticationType)
    func showPrivacyPolicy(userAgreementsType: UserAgreementsType)
    func showProfile()
    func showLogin()
}

protocol PasswordRecoveryOutput {
    func showEnterCodeFromSms(eventType: AuthenticationType)
    func showCreatingPassword(eventType: AuthenticationType, recovery: RecoveryType)
}

protocol EnterCodeFromSmsOutput {
    func showCreatingPassword(eventType: AuthenticationType)
    func showLogin()
}

protocol CreatePasswordOutput {
    func showProfile()
    func showLogin()
}

final class LoginCoordinator: Coordinator {
    var onStart: (() -> Void)?
    
    var onFinish: (() -> Void)?
    
    func start() {
        let loginViewModel = LoginViewModel(output: self)
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        router.push(loginViewController)
        
        onStart?()
    }
}

extension LoginCoordinator: LoginOutput {
    // кнопка зарегистрироваться
    func showRegistration() {
        let registrationViewModel = RegistrationViewModel(output: self)
        let registrationViewController = RegistrationViewController(viewModel: registrationViewModel)
        router.push(registrationViewController)
    }
    
    // кнопка забыли пароль
    func showPasswordRecovery(recoveryType: RecoveryType) {
        let passwordRecoveryViewModel = PasswordRecoveryViewModel(output: self, recoveryType: recoveryType)
        let passwordRecoveryViewController = PasswordRecoveryViewController(
            viewModel: passwordRecoveryViewModel,
            recoveryType: recoveryType
        )
        router.push(passwordRecoveryViewController)
    }
    
    // кнопка вперед
    func showProfile() {
        let tabBarCoordinator = coordinatorsFactory.makeTabBarCoordinator(parent: self) { [weak self] in
            self?.finish()
        }
        
        tabBarCoordinator.start()
    }
}

extension LoginCoordinator: RegistrationScreenOutput {
    func showEnterCodeFromSms(eventType: AuthenticationType) {
        let enterCodeFromSmsViewModel = EnterCodeFromSmsViewModel(output: self)
        enterCodeFromSmsViewModel.eventType = eventType
        let enterCodeFromSmsViewController = EnterCodeFromSmsViewController(
            viewModel: enterCodeFromSmsViewModel,
            authentificationType: eventType
        )
        router.push(enterCodeFromSmsViewController)
    }
    
    func showCreatingPassword(eventType: AuthenticationType) {
        let creatingPasswordViewModel = CreatingPasswordViewModel(output: self)
        creatingPasswordViewModel.eventType = eventType
        let creatingPasswordViewController = CreatingPasswordViewController(
            viewModel: creatingPasswordViewModel,
            creatingPasswordFor: eventType
        )
        router.push(creatingPasswordViewController)
    }
    
    func showPrivacyPolicy(userAgreementsType: UserAgreementsType) {
        let userAgreementsViewController = UserAgreementsViewController(userAgreementsType: userAgreementsType)
        
        router.push(userAgreementsViewController)
    }
    
    func showLogin() {
        router.pop()
    }
}

extension LoginCoordinator: PasswordRecoveryOutput {
    func showCreatingPassword(eventType: AuthenticationType, recovery: RecoveryType) {
        let creatingPasswordViewModel = CreatingPasswordViewModel(output: self)
        creatingPasswordViewModel.eventType = eventType
        creatingPasswordViewModel.recoveryType = recovery
        let creatingPasswordViewController = CreatingPasswordViewController(
            viewModel: creatingPasswordViewModel,
            creatingPasswordFor: eventType
        )
        router.push(creatingPasswordViewController)
    }
}

extension LoginCoordinator: EnterCodeFromSmsOutput { }

extension LoginCoordinator: CreatePasswordOutput { }

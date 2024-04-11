//
//  AuthViewModel.swift
//  BettaBank
//
//  Created by Борис Кравченко on 09.11.2023.
//

import Foundation
import Combine

protocol LoginViewModelPrototcol {
    func authenticateUser(phoneNumber: String, email: String, password: String, users: [User]) -> String?
    func showPasswordRecovery(recoveryType: RecoveryType)
    func showRegistration()
    func performNetworkRequest()
}

class LoginViewModel {
    private let output: LoginOutput
    var cancellables: Set<AnyCancellable> = []
    let networkService = NetworkService()
    
    init(output: LoginOutput) {
        self.output = output
    }
}

extension LoginViewModel: LoginViewModelPrototcol {
    func authenticateUser(phoneNumber: String, email: String, password: String, users: [User]) -> String? {
        
        // Проверка авторизации
        if let user = users.first(where: { $0.phoneNumber == phoneNumber || $0.email == email }) {
            if user.password == password {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.output.showProfile()
                }
                return TextLabels.LoginVC.autorizationSuccess
            } else {
                return TextLabels.LoginVC.wrongPassword
            }
        } else {
            return TextLabels.LoginVC.wrongPhone
        }
    }
    
    func showPasswordRecovery(recoveryType: RecoveryType) {
        output.showPasswordRecovery(recoveryType: recoveryType)
    }
    
    func showRegistration() {
        output.showRegistration()
    }
    
    func performNetworkRequest() {
        let cancellable = networkService.makeRequest(request: "").sink(receiveCompletion: { completion in
            switch completion {
            case .finished: break
            case .failure(let error): print("Ошибка: \(error)")
            }
        }, receiveValue: { (result: NetworkTestModel) in
            print("Полученные данные: \(result)")
        })
        cancellable.store(in: &cancellables)
    }
}

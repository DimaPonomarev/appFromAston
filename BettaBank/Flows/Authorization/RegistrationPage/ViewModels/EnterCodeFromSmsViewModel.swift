//
//  EnterCodeFromSmsViewModel.swift
//  BettaBank
//
//  Created by Dmitry Gorbunow on 11/4/23.
//

import Foundation

// MARK: - Constants

extension Int {
    static let secondsStep = 1
    static let secondsToFormatString = 10
}

private enum Constants {
    static let secondsBeforeResending: Int = 25
    static let timeInterval: Double = 1
}

protocol EnterCodeFromSmsViewModelProtocol {
    var eventType: AuthenticationType? { get set }
    var updateTimer: ((String, Bool, Bool) -> Void)? { get set }
    func startTimer()
    func resendButtonTapped()
    func goToCreatingPassword()
    func goToLogin()
    
}

final class EnterCodeFromSmsViewModel: EnterCodeFromSmsViewModelProtocol {
   
    var updateTimer: ((String, Bool, Bool) -> Void)?
    
    var eventType: AuthenticationType?

    // MARK: - Properties
    
    private let output: EnterCodeFromSmsOutput
    private var timer: Timer?
    private var seconds = Constants.secondsBeforeResending
    
    init(output: EnterCodeFromSmsOutput) {
        self.output = output
    }

    // MARK: - Public Methods
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: Constants.timeInterval, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    func resendButtonTapped() {
        seconds = Constants.secondsBeforeResending
        let timeString = "Повторная отправка через 0:\(seconds)".localized()
        updateTimer?(timeString, false, true)
        startTimer()
    }
    
    func goToCreatingPassword() {
        if let eventType {
            output.showCreatingPassword(eventType: eventType)
        }
    }
    
    func goToLogin() {
        output.showLogin()
    }

    // MARK: - objc Methods

    @objc private func update() {
        if seconds > 0 {
            seconds -= .secondsStep
            let timeString = seconds >= .secondsToFormatString 
            ? "Повторная отправка через 0:\(seconds)".localized()
            : "Повторная отправка через 0:0\(seconds)".localized()
            updateTimer?(timeString, false, true)
        } else {
            timer?.invalidate()
            updateTimer?("", true, false)
        }
    }
}

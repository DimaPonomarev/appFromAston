//
//  EnterCodeFromSmsViewController.swift
//  MVVM+C Demo
//
//  Created by Dmitry Gorbunow on 11/4/23.
//

import UIKit

// MARK: - Constants

private extension CGFloat {
    static let labelInterlineSpacing = 25.0
    static let stackSpacing = 5.0
    static let height12 = 12.0
    static let offset112 = 112.0
    static let offset95 = 95.0
}

private enum Constants {
    static let numberOfLinesInLabel = 2
    static let phoneNumberMaxLength = 16
    static let secondsBeforeResending = 25
    static let smsTextFieldHeight = 56
}

final class EnterCodeFromSmsViewController: UIViewController {

    // MARK: - Properties
    
    private var viewModel: EnterCodeFromSmsViewModelProtocol
    private var authentificationType: AuthenticationType

    // MARK: - init
    
    init(viewModel: EnterCodeFromSmsViewModelProtocol, authentificationType: AuthenticationType) {
        self.viewModel = viewModel
        self.authentificationType = authentificationType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Components
    
    private let enterCodeFromSmsLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.LoginVC.enterCodeFromSms
        label.font = Font.boldSmallL
        return label
    }()
    
    private let codeHasBeenSentLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.LoginVC.codeHasBeenSent
        label.numberOfLines = Constants.numberOfLinesInLabel
        label.font = Font.regularSmallL
        label.textAlignment = .left
        return label
    }()
    
    private let smsTextField = OneTimeCodeTextField()
    
    private let resendingLabel: UILabel = {
        let label = UILabel()
        label.font = Font.regularSmallL
        return label
    }()
    
    private let resendButton = CustomButton(title: TextLabels.LoginVC.resendSMS, size: .small)
    
    private let loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = .stackSpacing
        return stackView
    }()
    
    private let haveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.LoginVC.haveAccount
        label.numberOfLines = Constants.numberOfLinesInLabel
        label.font = Font.regularSmallL
        label.textAlignment = .left
        return label
    }()
    
    private let loginButton = CustomButton(title: TextLabels.LoginVC.login, size: .small)
    private let nextButton = CustomButton(title: TextLabels.LoginVC.further, size: .big)

    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        activateKeyboardRemoval()
        goToNextPageAfterEnteringCode()
        setupResendCodeTimer()
    }

    // MARK: - Private Methods
    
    private func setupView() {
        // TODO: привести к одному уровню абстракции
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        setupButtons()

        [haveAccountLabel, loginButton].forEach { loginStackView.addSubview($0)}
                
        [enterCodeFromSmsLabel, codeHasBeenSentLabel, smsTextField, nextButton, resendingLabel, resendButton, 
         loginStackView
        ].forEach { view.addSubview($0)}
      
        smsTextField.configure()
        setupConstraints()
        setTitle()
    }
    
    private func setTitle() {
        guard let eventType = viewModel.eventType else {
            return
        }
        
        switch eventType {
        case .registration:
            title = TextLabels.LoginVC.registration
        case .restorePassword:
            title = TextLabels.LoginVC.passwordRecovery
        }
    }
    
    private func setupButtons() {
        resendButton.isHidden = true
        resendButton.addTarget(self, action: #selector(resendButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func setupResendCodeTimer() {
        viewModel.updateTimer = { [weak self] timeString, timerStopped, buttonHidden in
            self?.resendingLabel.text = timeString
            self?.resendingLabel.isHidden = timerStopped
            self?.resendButton.isHidden = buttonHidden
        }
        viewModel.startTimer()
    }
    
    private func goToNextPageAfterEnteringCode() {
        smsTextField.didEnterLastDigit = { [weak self] code in
            print(code)
            guard let self else { return }
            self.viewModel.goToCreatingPassword()
        }
    }
    
    private func activateKeyboardRemoval() {
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func setupConstraints() {
        enterCodeFromSmsLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.top.equalToSuperview().offset(CGFloat.offset112)
        }
        
        codeHasBeenSentLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(enterCodeFromSmsLabel.snp.bottom).offset(Size.middleM)
        }
        
        smsTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(codeHasBeenSentLabel.snp.bottom).offset(Size.smallXL)
            make.height.equalTo(Constants.smsTextFieldHeight)
        }
        
        resendingLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(smsTextField.snp.bottom).offset(Size.smallM)
            make.height.equalTo(CGFloat.height12)
        }
        
        resendButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(smsTextField.snp.bottom).offset(Size.smallM)
            make.height.equalTo(CGFloat.height12)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.bottom.equalTo(loginStackView.snp.top).offset(-Size.smallXL)
            make.height.equalTo(Size.largeXL)
        }
        
        loginStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).offset(-Size.smallXL)
        }
    }

    // MARK: - @objc Methods
    
    @objc private func resendButtonTapped() {
        viewModel.resendButtonTapped()
    }
    
    @objc private func nextButtonTapped() {
        viewModel.goToCreatingPassword()
    }
    
    @objc private func loginButtonTapped() {
        viewModel.goToLogin()
    }
}

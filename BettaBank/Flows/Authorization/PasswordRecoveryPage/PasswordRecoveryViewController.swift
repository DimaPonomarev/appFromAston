//
//  PasswordRecoveryViewController.swift
//  BettaBank
//
//  Created by Dzhami Rakhmetov on 17/17/23.
//

import UIKit

private extension CGFloat {
    static let bigFontSize = 32.0
    static let averageFontSize = 16.0
    static let additionalFontSize = 20.0
    static let littleFontSize = 12.0
    static let labelInterlineSpacing = 25.0
    static let stackSpacing = 5.0
    static let mainHeight = 56.0
    static let additionalHeight = 38.0
    static let offset112 = 112.0
    static let offset24 = 24.0
    static let offset48 = 48.0
    static let offset95 = 95.0
    static let offset32 = 32.0
    static let offset16 = 16.0
    static let offset8 = 8.0
    static let borderWidth = 0.3
}

private enum Constants {
    static let numberOfLinesInLabel: Int = 2
    static let phoneNumberMaxLength: Int = 16
}

final class PasswordRecoveryViewController: UIViewController {

    // MARK: - Properties
    
    private var viewModel: PasswordRecoveryViewModelProtocol
    private var recoveryType: RecoveryType

    // MARK: - UI Components
    
    private let recoveryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: .additionalFontSize, weight: .bold)
        return label
    }()
    
    private let phoneTextField = CustomTextField(fieldType: .phone, placeholder: TextLabels.LoginVC.phoneNumber)
    private let emailTextField = CustomTextField(fieldType: .email, placeholder: TextLabels.LoginVC.email)
    
    private let nextButton = CustomButton(title: TextLabels.LoginVC.further, size: .big)

    // MARK: - init
    
    init(viewModel: PasswordRecoveryViewModelProtocol, recoveryType: RecoveryType) {
        self.viewModel = viewModel
        self.recoveryType = recoveryType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        
        emailTextField.delegate = self
        phoneTextField.delegate = self
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .textFieldPlaceholder
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        title = TextLabels.LoginVC.passwordRecovery
        
        nextButton.addTarget(self, action: #selector(nextButtonDidTapped), for: .touchUpInside)
        
        [recoveryLabel, phoneTextField, emailTextField, nextButton].forEach { view.addSubview($0) }
        
        switch recoveryType {
        case .phoneNumber:
            view.addSubview(phoneTextField)
            recoveryLabel.text = TextLabels.LoginVC.enterPhoneNumber
            phoneTextField.isHidden = false
            emailTextField.isHidden = true
        case .email:
            view.addSubview(emailTextField)
            recoveryLabel.text = TextLabels.LoginVC.enterEmail
            phoneTextField.isHidden = true
            emailTextField.isHidden = false
        }
    }
    
    private func setupConstraints() {
        recoveryLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(CGFloat.offset16)
            make.top.equalToSuperview().offset(CGFloat.offset112)
            make.height.equalTo(CGFloat.additionalHeight)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(CGFloat.offset16)
            make.top.equalTo(recoveryLabel.snp.bottom).offset(CGFloat.offset24)
            make.height.equalTo(CGFloat.mainHeight)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(CGFloat.offset16)
            make.top.equalTo(recoveryLabel.snp.bottom).offset(CGFloat.offset24)
            make.height.equalTo(CGFloat.mainHeight)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(CGFloat.offset16)
            make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).offset(-CGFloat.offset16)
            make.height.equalTo(CGFloat.offset48)
        }
    }
    
    private func updateUIWithPhoneValidation() {
        if viewModel.isPhoneNumberValid {
            nextButton.backgroundColor = .yellowButtonColor
            nextButton.layer.borderWidth = 0
            nextButton.setTitleColor(.black, for: .normal)
        } else {
            nextButton.backgroundColor = .grayButton
            nextButton.layer.borderWidth = .borderWidth
            nextButton.setTitleColor(.textFieldPlaceholder, for: .normal)
        }
    }
    
    private func updateUIWithEmailValidation() {
        if viewModel.isEmailValid {
            nextButton.backgroundColor = .yellowButtonColor
            nextButton.layer.borderWidth = 0
            nextButton.setTitleColor(.black, for: .normal)
        } else {
            nextButton.backgroundColor = .grayButton
            nextButton.layer.borderWidth = .borderWidth
            nextButton.setTitleColor(.textFieldPlaceholder, for: .normal)
        }
    }

    // MARK: - @objc Methods
    
    @objc private func nextButtonDidTapped() {
        // TODO: изменение состояния на биндингах
        viewModel.nextButtonTapped()
    }
}

// MARK: - UITextFieldDelegate

extension PasswordRecoveryViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        switch textField {
        case phoneTextField:
            textField.text = text.applyPatternOnNumbers(pattern: "+# (###) #######", replacementCharacter: "#")
            viewModel.phoneNumber = phoneTextField.text ?? ""
            updateUIWithPhoneValidation()
        case emailTextField:
            viewModel.email = emailTextField.text ?? ""
            updateUIWithEmailValidation()
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = Constants.phoneNumberMaxLength
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        return newString.count <= maxLength
    }
}

extension PasswordRecoveryViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

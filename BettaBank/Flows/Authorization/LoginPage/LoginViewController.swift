//
//  LoginViewController.swift
//  BettaBank
//
//  Created by Борис Кравченко on 09.11.2023.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: LoginViewModelPrototcol
    private let notification = NotificationCenter.default
    private var recoveryType: RecoveryType = .phoneNumber
    
    // MARK: - UI components
    
    lazy var warningPhoneLabel = UILabel()
    lazy var warningDocumentLabel = UILabel()
    lazy var phoneTextField = UITextField()
    lazy var documentNumberTextField = UITextField()
    lazy var passwordTextField = UITextField()
    lazy var contentView = UIView()
    lazy var logoImageView = UIImageView()
    lazy var bankName = UILabel()
    lazy var welcomeLabel = UILabel()
    lazy var warningPasswordLabel = UILabel()
    lazy var forgotPasswordButton = UIButton()
    lazy var forwardButton = UIButton()
    lazy var letRegisterButton = UIButton()
    lazy var noAccountLabel = UILabel()
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [TextLabels.LoginVC.phone, TextLabels.LoginVC.document])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.borderWidth = 0
        segmentedControl.selectedSegmentTintColor = .white
        segmentedControl.setTitleTextAttributes([
            .font: Font.regularSmallXL,
            .foregroundColor: UIColor.black], for: .normal)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    // MARK: - Init
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .textFieldPlaceholder
        configureUI()
        configureTextFields()
        showPhoneTextField()
        activateKeyboardRemoval()
        setupKeyboardNotifications()
        networkTest()
    }
    
    private func networkTest() {
        viewModel.performNetworkRequest()
    }
    
    private func updateForwardButton() {
        let phoneNumber = phoneTextField.text ?? ""
        let isPhoneValid = phoneNumber.count == 12 && phoneNumber.hasPrefix("+")
        
        let email = documentNumberTextField.text ?? ""
        let isEmailValid = Validator.isValidEmail(email)
        
        let password = passwordTextField.text ?? ""
        let isPasswordValid = (6...20).contains(password.count)
        
        forwardButton.isEnabled = (isPhoneValid || isEmailValid) && isPasswordValid
        
        if forwardButton.isEnabled {
            forwardButton.backgroundColor = .systemYellow
            forwardButton.setTitleColor(.white, for: .normal)
        } else {
            forwardButton.backgroundColor = .systemYellow.withAlphaComponent(0.5)
            forwardButton.setTitleColor(.black, for: .normal)
        }
    }
    
    private func hideLogo(isHidden: Bool) {
        logoImageView.isHidden = isHidden
        bankName.isHidden = isHidden
    }
    
    //  методы NotificationCenter для открытия и скрытия клавитатуры
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver( self,
                                                selector: #selector(keyboardWillShow),
                                                name: UIResponder.keyboardWillShowNotification,
                                                object: nil)
        
        NotificationCenter.default.addObserver( self,
                                                selector: #selector(keyboardWillHide),
                                                name: UIResponder.keyboardWillHideNotification,
                                                object: nil)
    }
    
    private func activateKeyboardRemoval() {
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - @objc funcs
    
    // Проверка валидности номера телефона
    @objc func phoneTextFieldDidChange() {
        let phoneNumber = phoneTextField.text ?? ""
        let isPhoneValid = phoneNumber.count == 12 && phoneNumber.hasPrefix("+")
        var phoneError = ""
        phoneTextField.removeHighlight()
        
        if !isPhoneValid {
            phoneError = TextLabels.LoginVC.phoneError
            phoneTextField.highlightAsError()
        }
        warningPhoneLabel.text = phoneError
        updateForwardButton()
    }
    
    // Проверка валидности email
    @objc func documentNumberTextFieldDidChange() {
        let email = documentNumberTextField.text ?? ""
        let isEmailValid = Validator.isValidEmail(email)
        var emailError = ""
        documentNumberTextField.removeHighlight()
        
        if !isEmailValid {
            emailError = TextLabels.LoginVC.emailError
            documentNumberTextField.highlightAsError()
        }
        warningDocumentLabel.text = emailError
        updateForwardButton()
    }
    
    // Проверка валидности пароля
    @objc func passwordTextFieldDidChange() {
        let password = passwordTextField.text ?? ""
        let isPasswordValid = (6...20).contains(password.count)
        var passwordError = ""
        passwordTextField.removeHighlight()
        
        if !isPasswordValid {
            passwordError = TextLabels.LoginVC.passwordError
            passwordTextField.highlightAsError()
        }
        warningPasswordLabel.text = passwordError
        updateForwardButton()
    }
    
    // проверка введенных данных авторизации
    @objc func forwardButtonTapped() {
        let phoneNumber = phoneTextField.text ?? ""
        let email = documentNumberTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let message = viewModel.authenticateUser(phoneNumber: phoneNumber, email: email, password: password, users: users)
        warningPasswordLabel.text = message
    }
    
    @objc func clearPhoneTextField() {
        phoneTextField.text = ""
    }
    
    @objc func clearDocumentNumberTextField() {
        documentNumberTextField.text = ""
    }
    
    @objc func forgotPasswordButtonTapped() {
        viewModel.showPasswordRecovery(recoveryType: recoveryType)
    }
    
    @objc func letRegisterButtonTapped() {
        viewModel.showRegistration()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let buttonFrameInWindow = forwardButton.convert(forwardButton.bounds, to: nil)
            let bottomOfButton = buttonFrameInWindow.maxY
            
            // Рассчитываем, насколько нужно поднять экран
            let offset = bottomOfButton + 10 - (self.view.frame.size.height - keyboardSize.height)
            if offset > 0 {
                self.view.frame.origin.y -= offset
                hideLogo(isHidden: true)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
        hideLogo(isHidden: false)
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            recoveryType = .phoneNumber
            showPhoneTextField()
        case 1:
            recoveryType = .email
            showDocumentNumberTextField()
        default:
            break
        }
    }
}

// MARK: - Extensions скрытие клавиатуры по нажатию на return

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == phoneTextField {
            if let text = textField.text, !text.hasPrefix("+7") {
                textField.text = "+7" + text
            }
        }
    }
}

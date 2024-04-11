//
//  RegistrationViewController.swift
//  MVVM+C Demo
//
//  Created by Dmitry Gorbunow on 11/3/23.
//

import UIKit
import SnapKit

// MARK: - Constants

private extension CGFloat {
    static let additionalFontSize = 20.0
    static let labelInterlineSpacing = 25.0
    static let stackSpacing = 5.0
    static let mainHeight = 55.0
    static let additionalHeight = 40.0
    static let offset112 = 110.0
    static let offset95 = 95.0
}

private enum Constants {
    static let numberOfLinesInLabel: Int = 2
    static let phoneNumberMaxLength: Int = 16
    static let documentNumberMaxLenght: Int = 10
    static let borderWidthNextButton: CGFloat = 1
}

final class RegistrationViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: RegistrationViewModelProtocol
    
    // MARK: - init
    
    init(viewModel: RegistrationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    private lazy var termsTextView = TermsTextView()
    
    private lazy var loginSegmentControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [TextLabels.LoginVC.phone, TextLabels.LoginVC.document])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .white
        let font = Font.mediumSmallXL
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        segmentedControl.addTarget(self, action: #selector(loginSegmetControlTapped), for: .valueChanged)
        return segmentedControl
    }()
    
    private let enterPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.LoginVC.enterPhoneNumber
        label.font = UIFont.systemFont(ofSize: .additionalFontSize, weight: .bold)
        return label
    }()
    
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
    
    private let phoneNumberWarningLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.LoginVC.phoneError
        label.textColor = .labelRed
        label.isHidden = true
        label.numberOfLines = Constants.numberOfLinesInLabel
        label.font = Font.regularSmallL
        label.textAlignment = .left
        return label
    }()
    
    private let documentNumberWarningLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.LoginVC.documentError
        label.textColor = .labelRed
        label.isHidden = true
        label.numberOfLines = Constants.numberOfLinesInLabel
        label.font = Font.regularSmallL
        label.textAlignment = .left
        return label
    }()
    
    private let emailWarningLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.LoginVC.emailError
        label.textColor = .labelRed
        label.isHidden = true
        label.numberOfLines = Constants.numberOfLinesInLabel
        label.font = Font.regularSmallL
        label.textAlignment = .left
        return label
    }()
    
    private let loginButton = CustomButton(title: TextLabels.LoginVC.login, size: .small)
    private let nextButton = CustomButton(title: TextLabels.LoginVC.further, size: .big)
    
    private let phoneTextField = CustomTextField(fieldType: .phone, placeholder: TextLabels.LoginVC.phoneNumber)
    private let documentTextField = CustomTextField(fieldType: .document, placeholder: TextLabels.LoginVC.documentData)
    private let emailTextField = CustomTextField(fieldType: .email, placeholder: TextLabels.LoginVC.email)
    
    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        activateKeyboardRemoval()
        phoneTextField.delegate = self
        documentTextField.delegate = self
        emailTextField.delegate = self
        termsTextView.delegate = self
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .textFieldPlaceholder
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        title = TextLabels.LoginVC.registration
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        documentTextField.isHidden = true
        emailTextField.isHidden = true
        
        [loginSegmentControl, enterPhoneNumberLabel, phoneTextField, documentTextField,
         termsTextView, nextButton].forEach { view.addSubview($0) }
        
        [haveAccountLabel, loginButton].forEach { loginStackView.addArrangedSubview($0) }
        
        [loginStackView, phoneNumberWarningLabel, documentNumberWarningLabel,
         emailTextField, emailWarningLabel  ].forEach { view.addSubview($0) }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        loginSegmentControl.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.top.equalToSuperview().offset(CGFloat.offset112)
            make.height.equalTo(CGFloat.additionalHeight)
        }
        
        enterPhoneNumberLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(loginSegmentControl.snp.bottom).offset(Size.middleM)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(enterPhoneNumberLabel.snp.bottom).offset(Size.middleM)
            make.height.equalTo(CGFloat.mainHeight)
        }
        
        phoneNumberWarningLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(phoneTextField.snp.bottom).offset(Size.smallS)
        }
        
        documentNumberWarningLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(documentTextField.snp.bottom).offset(Size.smallS)
        }
        
        documentTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(enterPhoneNumberLabel.snp.bottom).offset(Size.middleM)
            make.height.equalTo(CGFloat.mainHeight)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(documentTextField.snp.bottom).offset(Size.middleM)
            make.height.equalTo(CGFloat.mainHeight)
        }
        
        emailWarningLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(emailTextField.snp.bottom).offset(Size.smallS)
        }
        
        termsTextView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.bottom.equalTo(nextButton.snp.top).offset(-Size.smallXL)
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
    
    private func activateKeyboardRemoval() {
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func segmentControlFirstItemTapped() {
        documentTextField.clearText()
        emailTextField.clearText()
        enterPhoneNumberLabel.text = TextLabels.LoginVC.enterPhoneNumber
        phoneTextField.isHidden = false
        documentTextField.isHidden = true
        emailTextField.isHidden = true
        documentNumberWarningLabel.isHidden = true
        emailWarningLabel.isHidden = true
    }
    
    private func segmentControlSecondItemTapped() {
        phoneTextField.clearText()
        enterPhoneNumberLabel.text = TextLabels.LoginVC.enterDocumentNumber
        documentTextField.isHidden = false
        emailTextField.isHidden = false
        phoneTextField.isHidden = true
        phoneNumberWarningLabel.isHidden = true
        documentNumberWarningLabel.isHidden = true
        emailWarningLabel.isHidden = true
    }
    
    // MARK: - @objc Methods
    
    @objc private func loginSegmetControlTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            segmentControlFirstItemTapped()
        case 1:
            segmentControlSecondItemTapped()
        default:
            break
        }
    }
    
    @objc private func nextButtonTapped() {
        guard viewModel.isPhoneNumberValid || viewModel.isEmailValid && viewModel.isDocumentValid else { return }
        switch loginSegmentControl.selectedSegmentIndex {
        case 0:
            viewModel.goToEnterCodeFromSms()
        case 1:
            viewModel.goToCreatingPassword()
        default:
            break
        }
    }
    
    @objc private func loginButtonTapped() {
        viewModel.goToLogin()
    }
}

// MARK: - UITextFieldDelegate

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        switch textField {
        case phoneTextField:
            phoneNumberWarningLabel.isHidden = false
            textField.text = text.applyPatternOnNumbers(pattern: "+# (###) #######", replacementCharacter: "#")
            viewModel.phoneNumber = phoneTextField.text ?? ""
            updateUIWithPhoneValidation()
        case documentTextField:
            viewModel.document = documentTextField.text ?? ""
            let documentLength = documentTextField.text?.count ?? 0
            documentNumberWarningLabel.isHidden = (documentLength >= 1 && documentLength <= 9) || documentLength > 10
            updateUIWithDocumentValidation() // Update here
        case emailTextField:
            viewModel.email = emailTextField.text ?? ""
            emailWarningLabel.isHidden = viewModel.isEmailValid
            updateUIWithEmailValidation()
        default:
            break
        }
    }
}

// MARK: - UITextViewDelegate

extension RegistrationViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        let selectedText = textView.textStorage.attributedSubstring(from: characterRange).string
        
        if selectedText == TextLabels.LoginVC.termsOfUse {
            viewModel.goToPrivacyPolicy(userAgreementsType: .termsOfUse)
        } else if selectedText == TextLabels.LoginVC.privacyPolicy {
            viewModel.goToPrivacyPolicy(userAgreementsType: .privacyPolicy)
        } else if selectedText == TextLabels.LoginVC.dataStorage {
            viewModel.goToPrivacyPolicy(userAgreementsType: .dataStorage)
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case phoneTextField:
            phoneTextField.removeHighlight()
            phoneNumberWarningLabel.isHidden = true
        case documentTextField:
            documentTextField.removeHighlight()
            documentNumberWarningLabel.isHidden = true
        case emailTextField:
            emailTextField.removeHighlight()
            emailWarningLabel.isHidden = true
        default:
            break
        }
    }
}

extension RegistrationViewController {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    private func updateUIWithPhoneValidation() {
        if viewModel.isPhoneNumberValid {
            phoneTextField.removeHighlight()
            phoneNumberWarningLabel.isHidden = true
            nextButton.backgroundColor = .yellowButtonColor
            nextButton.layer.borderWidth = 0
            nextButton.setTitleColor(.black, for: .normal)
        } else {
            phoneNumberWarningLabel.isHidden = false
            phoneTextField.highlightAsError()
            nextButton.backgroundColor = .grayButton
            nextButton.layer.borderWidth = Constants.borderWidthNextButton
            nextButton.setTitleColor(.textFieldPlaceholder, for: .normal)
        }
    }
    
    private func updateUIWithDocumentValidation() {
        guard let documentText = documentTextField.text else {
            documentNumberWarningLabel.isHidden = true
            return
        }
        
        let documentLength = documentText.count
        if documentLength >= 10 {
            documentNumberWarningLabel.isHidden = true
            documentTextField.removeHighlight()
        } else {
            documentNumberWarningLabel.isHidden = false
            documentTextField.highlightAsError()
        }
    }
    
    private func updateUIWithEmailValidation() {
        if viewModel.isEmailValid {
            emailWarningLabel.isHidden = true
            emailTextField.removeHighlight()
        } else {
            emailWarningLabel.isHidden = false
            emailTextField.highlightAsError()
        }
        
        if viewModel.isDocumentValid && viewModel.isEmailValid {
            phoneNumberWarningLabel.isHidden = true
            nextButton.backgroundColor = .yellowButtonColor
            nextButton.layer.borderWidth = 0
            nextButton.setTitleColor(.black, for: .normal)
        } else {
            nextButton.backgroundColor = .grayButton
            nextButton.layer.borderWidth = Constants.borderWidthNextButton
            nextButton.setTitleColor(.textFieldPlaceholder, for: .normal)
        }
    }
}

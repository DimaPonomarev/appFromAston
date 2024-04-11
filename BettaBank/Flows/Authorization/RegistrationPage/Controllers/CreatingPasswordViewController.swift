//
//  CreatingPasswordViewController.swift
//  MVVM+C Demo
//
//  Created by Dmitry Gorbunow on 11/6/23.
//

import UIKit

// MARK: - Constants

// TODO: разнести в метрики
private extension CGFloat {
    static let bigFontSize = 32.0
    static let averageFontSize = 16.0
    static let additionalFontSize = 20.0
    static let littleFontSize = 12.0
    static let labelInterlineSpacing = 25.0
    static let stackSpacing = 5.0
    static let additionalStackSpacing = 8.0
    static let height12 = 12.0
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
    static let secondsBeforeResending: Int = 25
}

final class CreatingPasswordViewController: UIViewController {

    // MARK: - Properties
    
    private var viewModel: CreatingPasswordViewModelProtocol
    private var creatingPasswordFor: AuthenticationType

    // MARK: - init
    
    init(viewModel: CreatingPasswordViewModelProtocol, creatingPasswordFor: AuthenticationType) {
        self.viewModel = viewModel
        self.creatingPasswordFor = creatingPasswordFor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Components
    
    private let createPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.LoginVC.createPassword
        label.font = UIFont.systemFont(ofSize: .additionalFontSize, weight: .bold)
        return label
    }()
    
    private let firstRestrictionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let firstRestrictionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "crossMark")
        return imageView
    }()
    
    private let firstPasswordRestrictionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.LoginVC.numberOfCharacters
        label.textColor = .labelRed
        label.font = UIFont.systemFont(ofSize: .littleFontSize, weight: .regular)
        return label
    }()
    
    private let secondRestrictionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let secondRestrictionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "crossMark")
        return imageView
    }()
    
    private let secondPasswordRestrictionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.LoginVC.lowercaseAndUppercase
        label.textColor = .labelRed
        label.font = UIFont.systemFont(ofSize: .littleFontSize, weight: .regular)
        return label
    }()
    
    private let thirdRestrictionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let thirdRestrictionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "crossMark")
        return imageView
    }()
    
    private let thirdPasswordRestrictionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.LoginVC.haveNumbers
        label.textColor = .labelRed
        label.font = UIFont.systemFont(ofSize: .littleFontSize, weight: .regular)
        return label
    }()
    
    private let fourthRestrictionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let fourthRestrictionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "crossMark")
        return imageView
    }()
    
    private let fourthPasswordRestrictionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.LoginVC.haveSpecialCharacters
        label.numberOfLines = 0
        label.textColor = .labelRed
        label.font = UIFont.systemFont(ofSize: .littleFontSize, weight: .regular)
        return label
    }()
    
    private let passwordRestrictionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .additionalStackSpacing
        return stackView
    }()
    
    private let passwordTextField = CustomTextField(fieldType: .password, placeholder: TextLabels.LoginVC.password)
    private let secondPasswordTextField = CustomTextField(fieldType: .password, placeholder: TextLabels.LoginVC.repeatPassword)
    
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
        label.font = UIFont.systemFont(ofSize: .littleFontSize)
        label.textAlignment = .left
        return label
    }()
    
    private let loginButton = CustomButton(title: TextLabels.LoginVC.login, size: .small)
    private let nextButton = CustomButton(title: TextLabels.LoginVC.further, size: .big)

    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateKeyboardRemoval()
    }

    // MARK: - Private Methods
    
    private func setupViews() {
        // TODO: привести к одному уровню абстракции
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        passwordTextField.delegate = self
        secondPasswordTextField.delegate = self
        
        passwordTextField.addTarget(self, action: #selector(firstTextFieldDidChange), for: .editingChanged)
        secondPasswordTextField.addTarget(self, action: #selector(secondTextFieldDidChange), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        view.addSubview(createPasswordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(secondPasswordTextField)
        view.addSubview(passwordRestrictionsStackView)
        
        firstRestrictionStackView.addArrangedSubview(firstRestrictionImageView)
        firstRestrictionStackView.addArrangedSubview(firstPasswordRestrictionLabel)
        
        secondRestrictionStackView.addArrangedSubview(secondRestrictionImageView)
        secondRestrictionStackView.addArrangedSubview(secondPasswordRestrictionLabel)
        
        thirdRestrictionStackView.addArrangedSubview(thirdRestrictionImageView)
        thirdRestrictionStackView.addArrangedSubview(thirdPasswordRestrictionLabel)
        
        fourthRestrictionStackView.addArrangedSubview(fourthRestrictionImageView)
        fourthRestrictionStackView.addArrangedSubview(fourthPasswordRestrictionLabel)
        
        passwordRestrictionsStackView.addArrangedSubview(firstRestrictionStackView)
        passwordRestrictionsStackView.addArrangedSubview(secondRestrictionStackView)
        passwordRestrictionsStackView.addArrangedSubview(thirdRestrictionStackView)
        passwordRestrictionsStackView.addArrangedSubview(fourthRestrictionStackView)
        view.addSubview(nextButton)
        loginStackView.addArrangedSubview(haveAccountLabel)
        loginStackView.addArrangedSubview(loginButton)
        view.addSubview(loginStackView)
        
        setupConstraints()
        
        switch creatingPasswordFor {
        case .registration:
            title = TextLabels.LoginVC.registration
            loginStackView.isHidden = false
        case .restorePassword:
            title = TextLabels.LoginVC.passwordRecovery
            nextButton.setTitle(TextLabels.LoginVC.changePassword, for: .normal)
            loginStackView.isHidden = true
        }
    }
        
    private func setupConstraints() {
        createPasswordLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(CGFloat.offset16)
            make.top.equalToSuperview().offset(CGFloat.offset112)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(CGFloat.offset16)
            make.top.equalTo(createPasswordLabel.snp.bottom).offset(CGFloat.offset24)
            make.height.equalTo(CGFloat.mainHeight)
        }
        
        passwordRestrictionsStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(CGFloat.offset16)
            make.top.equalTo(passwordTextField.snp.bottom).offset(CGFloat.offset16)
        }
        
        secondPasswordTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(CGFloat.offset16)
            make.top.equalTo(passwordRestrictionsStackView.snp.bottom).offset(CGFloat.offset16)
            make.height.equalTo(CGFloat.mainHeight)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(CGFloat.offset16)
            make.bottom.equalTo(loginStackView.snp.top).offset(-CGFloat.offset16)
            make.height.equalTo(CGFloat.offset48)
        }
        
        loginStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).offset(-CGFloat.offset16)
        }
    }
    
    private func activateKeyboardRemoval() {
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func updateUIWithValidation() {
        firstRestrictionImageView.image = viewModel.isLengthValid ? UIImage(named: "checkMark") : UIImage(named: "crossMark")
        firstPasswordRestrictionLabel.textColor = viewModel.isLengthValid ? .labelGreen : .labelRed
        
        secondRestrictionImageView.image = viewModel.isLowerUpperValid ? UIImage(named: "checkMark") : UIImage(named: "crossMark")
        secondPasswordRestrictionLabel.textColor = viewModel.isLowerUpperValid ? .labelGreen : .labelRed
        
        thirdRestrictionImageView.image = viewModel.isNumberValid ? UIImage(named: "checkMark") : UIImage(named: "crossMark")
        thirdPasswordRestrictionLabel.textColor = viewModel.isNumberValid ? .labelGreen : .labelRed
        
        fourthRestrictionImageView.image = viewModel.isSpecialCharacterValid ? UIImage(named: "checkMark") : UIImage(named: "crossMark")
        fourthPasswordRestrictionLabel.textColor = viewModel.isSpecialCharacterValid ? .labelGreen : .labelRed
    }
    
    private func updateNextButtonWithValidation() {
        if viewModel.isPasswordMatching {
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
    
    @objc private func firstTextFieldDidChange() {
        guard let text = passwordTextField.text else { return }
        viewModel.password = text
        updateUIWithValidation()
    }
    
    @objc private func secondTextFieldDidChange() {
        guard let text = secondPasswordTextField.text else { return }
        viewModel.secondPassword = text
        updateNextButtonWithValidation()
    }
    
    @objc private func loginButtonTapped() {
        viewModel.goToLogin()
    }
    
    @objc private func nextButtonTapped() {
        viewModel.showProfile()
    }
}

extension CreatingPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

//
//  ChangingAppPasswordViewController.swift
//  BettaBank
//
//  Created by Борис Кравченко on 16.12.2023.
//

import UIKit
import SnapKit

// MARK: - Constants

private enum Constants {
    static let additionalFontSize = 20.0
    static let mainHeight = 56.0
    static let offset150 = 150.0
    static let borderWidth = 0.3
    static let borderWidthTextfield: CGFloat = 1

}

final class ChangingAppPasswordViewController: UIViewController {

    // MARK: - Properties
    private var viewModel: ChangingAppPasswordViewModelProtocol
    
    // MARK: - init
    init(viewModel: ChangingAppPasswordViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    private let createPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.LoginVC.createPassword
        label.font = UIFont.systemFont(ofSize: Constants.additionalFontSize, weight: .bold)
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
        imageView.alpha = .zero
        return imageView
    }()
    
    private let firstPasswordRestrictionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.ChangingAppPassword.numberOfCharacters
        label.textColor = .white
        label.font = Font.regularSmallL
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
        imageView.alpha = .zero
        return imageView
    }()
    
    private let secondPasswordRestrictionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.ChangingAppPassword.haveNumbers
        label.textColor = .white
        label.font = Font.regularSmallL
        return label
    }()
    
    private let thirdPasswordRestrictionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.ChangingAppPassword.passwordsDontMatch
        label.textColor = .white
        label.font = Font.regularSmallL
        return label
    }()
    
    private let oldPasswordRestrictionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.ChangingAppPassword.incorrectOldPin
        label.textColor = .white
        label.font = Font.regularSmallL
        return label
    }()
    
    private let passwordRestrictionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Size.smallM
        return stackView
    }()
    
    private let oldPasswordTextField = CustomTextField(fieldType: .appPassword, placeholder: CustomTextFieldPlaceholder.enterOldPassword)
    private let newPasswordTextField = CustomTextField(fieldType: .appPassword, placeholder: CustomTextFieldPlaceholder.enterNewPassword)
    private let repeatPasswordTextField = CustomTextField(fieldType: .appPassword, placeholder: CustomTextFieldPlaceholder.repeatNewPassword)
    
    private let changePasswordButton = CustomButton(title: TextLabels.ChangingAppPassword.changeAppPasswordButtonText, size: .big)

    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateKeyboardRemoval()
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        title = TextLabels.ChangingAppPassword.titleOfVC
        
        setupBackNavigationButton(type: .pop)
        
        oldPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        
        oldPasswordTextField.addTarget(self, action: #selector(oldPasswordTextFieldDidChange), for: .editingChanged)
        newPasswordTextField.addTarget(self, action: #selector(newPasswordTextFieldDidChange), for: .editingChanged)
        repeatPasswordTextField.addTarget(self, action: #selector(repeatPasswordTextFieldDidChange), for: .editingChanged)
        
        view.addSubview(createPasswordLabel)
        view.addSubview(oldPasswordTextField)
        view.addSubview(oldPasswordRestrictionLabel)
        view.addSubview(newPasswordTextField)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(changePasswordButton)
        view.addSubview(passwordRestrictionsStackView)
        view.addSubview(thirdPasswordRestrictionLabel)
        
        firstRestrictionStackView.addArrangedSubview(firstRestrictionImageView)
        firstRestrictionStackView.addArrangedSubview(firstPasswordRestrictionLabel)
        
        secondRestrictionStackView.addArrangedSubview(secondRestrictionImageView)
        secondRestrictionStackView.addArrangedSubview(secondPasswordRestrictionLabel)
        
        passwordRestrictionsStackView.addArrangedSubview(firstRestrictionStackView)
        passwordRestrictionsStackView.addArrangedSubview(secondRestrictionStackView)
        
        changePasswordButton.isUserInteractionEnabled = true
        changePasswordButton.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
        
        setupConstraints()
    }

    private func setupConstraints() {
        
        createPasswordLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Constants.offset150)
        }
        
        oldPasswordTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(createPasswordLabel.snp.bottom).offset(Size.smallXL)
            make.height.equalTo(Constants.mainHeight)
        }
        
        oldPasswordRestrictionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(oldPasswordTextField.snp.bottom).offset(Size.smallM)
        }
        
        newPasswordTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(oldPasswordRestrictionLabel.snp.bottom).offset(Size.smallXL)
            make.height.equalTo(Constants.mainHeight)
        }
        
        passwordRestrictionsStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(Size.smallM)
        }

        repeatPasswordTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(passwordRestrictionsStackView.snp.bottom).offset(Size.smallXL)
            make.height.equalTo(Constants.mainHeight)
        }
        
        thirdPasswordRestrictionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(Size.smallM)
        }

        changePasswordButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(Size.smallXL)
            make.leading.trailing.equalToSuperview().inset(Size.smallXL)
            make.height.equalTo(Size.largeXL)
        }
    }
    
    private func activateKeyboardRemoval() {
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func updateNewUIWithValidation() {
        firstRestrictionImageView.image = viewModel.isLengthValid ? UIImage(named: "checkMark") : UIImage(named: "crossMark")
        firstRestrictionImageView.alpha = 1
        firstPasswordRestrictionLabel.textColor = viewModel.isLengthValid ? .labelGreen : .labelRed
        
        secondRestrictionImageView.image = viewModel.isNumberValid ? UIImage(named: "checkMark") : UIImage(named: "crossMark")
        secondRestrictionImageView.alpha = 1
        secondPasswordRestrictionLabel.textColor = viewModel.isNumberValid ? .labelGreen : .labelRed
        
        newPasswordTextField.layer.borderColor = viewModel.isLengthValid ? UIColor.labelGreen.cgColor : UIColor.labelRed.cgColor
        newPasswordTextField.layer.borderWidth = Constants.borderWidthTextfield
    }
    
    private func updateRepeatUIWithValidation() {
        thirdPasswordRestrictionLabel.textColor = viewModel.isPasswordMatching ? .labelGreen.withAlphaComponent(.zero) : .labelRed
        repeatPasswordTextField.layer.borderColor = viewModel.isPasswordMatching ? UIColor.labelGreen.cgColor : UIColor.labelRed.cgColor
        repeatPasswordTextField.layer.borderWidth = Constants.borderWidthTextfield
    }
    
    private func updateUIForOldWithValidation() {
        oldPasswordRestrictionLabel.textColor = viewModel.isOldPasswordValid ? .labelGreen.withAlphaComponent(.zero) : .labelRed
        oldPasswordTextField.layer.borderColor = viewModel.isOldPasswordValid ? UIColor.labelGreen.cgColor : UIColor.labelRed.cgColor
        oldPasswordTextField.layer.borderWidth = viewModel.isOldPasswordValid ? .zero : Constants.borderWidthTextfield
    }
    
    private func updateNextButtonWithValidation() {
        if viewModel.isPasswordMatching {
            changePasswordButton.backgroundColor = .yellowButtonColor
            changePasswordButton.layer.borderWidth = .zero
            changePasswordButton.setTitleColor(.black, for: .normal)
        } else {
            changePasswordButton.backgroundColor = .grayButton
            changePasswordButton.layer.borderWidth = Constants.borderWidth
            changePasswordButton.setTitleColor(.textFieldPlaceholder, for: .normal)
        }
    }

    // MARK: - @objc Methods
        
    @objc private func oldPasswordTextFieldDidChange() {
        guard let text = oldPasswordTextField.text else { return }
        viewModel.oldPassword = text
        updateUIForOldWithValidation()
        updateNextButtonWithValidation()
    }

    @objc private func newPasswordTextFieldDidChange() {
        guard let text = newPasswordTextField.text else { return }
        viewModel.newPassword = text
        updateNewUIWithValidation()
        updateChangePasswordButton()
        updateNextButtonWithValidation()
    }

    @objc private func repeatPasswordTextFieldDidChange() {
        guard let text = repeatPasswordTextField.text else { return }
        viewModel.repeatPassword = text
        updateRepeatUIWithValidation()
        updateChangePasswordButton()
        updateNextButtonWithValidation()
    }

    private func updateChangePasswordButton() {
        changePasswordButton.isEnabled = viewModel.isPasswordMatching
    }
    
    @objc private func changePasswordButtonTapped() {
        viewModel.performPasswordChange()
        viewModel.changeDidTapped()
    }
}

extension ChangingAppPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

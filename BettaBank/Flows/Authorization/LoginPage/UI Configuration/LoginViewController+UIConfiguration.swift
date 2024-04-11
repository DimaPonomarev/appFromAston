//
//  LoginViewController+UIConfiguration.swift
//  BettaBank
//
//  Created by Dzhami on 08.12.2023.
//

import UIKit

private enum Constants {
    static let segmentControllHeight = 38.0
    static let forwardButtonHeight = 50.0
    static let logoTopInset = 100.0
    static let logoWidth = 70.0
    static let logoHeight = 90.0
}

extension LoginViewController {
    
    func configureUI() {
        addViwes()
        setupViews()
        makeConstraints()
    }
    
    func addViwes() {
        view.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(bankName)
        contentView.addSubview(welcomeLabel)
        contentView.addSubview(segmentedControl)
        contentView.addSubview(documentNumberTextField)
        contentView.addSubview(phoneTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(warningPasswordLabel)
        contentView.addSubview(warningPhoneLabel)
        contentView.addSubview(warningDocumentLabel)
        contentView.addSubview(forgotPasswordButton)
        contentView.addSubview(forwardButton)
        view.addSubview(letRegisterButton)
        view.addSubview(noAccountLabel)
    }
    
    func setupViews() {
        logoImageView.image = UIImage(named: "Logo")
        logoImageView.contentMode = .scaleAspectFill
        bankName.text = TextLabels.LoginVC.bankNameText
        bankName.font = Font.regularMiddleM
        welcomeLabel.text = TextLabels.LoginVC.welcomeText
        welcomeLabel.textAlignment = .left
        welcomeLabel.font = Font.boldMiddleM
        welcomeLabel.numberOfLines = 0
        warningPasswordLabel.textColor = .red
        warningPasswordLabel.textAlignment = .left
        warningPasswordLabel.font = Font.regularSmallXL
        warningPhoneLabel.textColor = .red
        warningPhoneLabel.textAlignment = .left
        warningPhoneLabel.font = Font.regularSmallXL
        warningDocumentLabel.textColor = .red
        warningDocumentLabel.textAlignment = .left
        warningDocumentLabel.font = Font.regularSmallXL
        
        forgotPasswordButton.setTitle(TextLabels.LoginVC.forgotPassword, for: .normal)
        let buttonText = TextLabels.LoginVC.forgotPassword
        
        let attributedText = NSMutableAttributedString(string: buttonText)
        attributedText.addAttribute(
            NSAttributedString.Key.underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSMakeRange(0, buttonText.count))
        
        forgotPasswordButton.setAttributedTitle(attributedText, for: .normal)
        forgotPasswordButton.setTitleColor(.systemBlue, for: .normal)
        forgotPasswordButton.titleLabel?.font = Font.regularSmallL
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        forwardButton.setTitle(TextLabels.LoginVC.next, for: .normal)
        forwardButton.setTitleColor(.black, for: .normal)
        forwardButton.titleLabel?.font = Font.regularSmallXL
        forwardButton.layer.cornerRadius = Size.smallM
        forwardButton.backgroundColor = .systemGray5
        forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        
        let registerButtonText = TextLabels.LoginVC.register
        let registerAttributedText = NSMutableAttributedString(string: registerButtonText)
        registerAttributedText.addAttribute(
            NSAttributedString.Key.underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSMakeRange(0, registerButtonText.count))
        
        letRegisterButton.setTitle(TextLabels.LoginVC.register, for: .normal)
        letRegisterButton.setAttributedTitle(registerAttributedText, for: .normal)
        letRegisterButton.setTitleColor(.systemBlue, for: .normal)
        letRegisterButton.titleLabel?.font = Font.regularSmallL
        letRegisterButton.addTarget(self, action: #selector(letRegisterButtonTapped), for: .touchUpInside)
        
        noAccountLabel.text = TextLabels.LoginVC.noAccount
        noAccountLabel.textColor = .black
        noAccountLabel.textAlignment = .right
        noAccountLabel.font = Font.regularSmallL
    }
    
    func makeConstraints() {
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(Constants.logoTopInset)
            make.width.equalTo(Constants.logoWidth)
            make.height.equalTo(Constants.logoHeight)
        }
        bankName.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(Size.smallL)
            make.centerX.equalToSuperview()
        }
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(bankName.snp.bottom).offset(Size.middleXL)
            make.leading.trailing.equalToSuperview().inset(Size.middleS)
        }
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(Size.middleXL)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Size.middleS)
            make.height.equalTo(Size.largeM)
        }
        documentNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(Size.middleS)
            make.leading.trailing.equalToSuperview().inset(Size.middleS)
        }
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(Size.middleS)
            make.leading.trailing.equalToSuperview().inset(Size.middleS)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(Size.middleM)
            make.leading.trailing.equalToSuperview().inset(Size.middleS)
        }
        warningPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(Size.smallS)
            make.leading.trailing.equalToSuperview().inset(Size.middleS)
        }
        warningPhoneLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(Size.smallS)
            make.leading.trailing.equalToSuperview().inset(Size.middleS)
        }
        warningDocumentLabel.snp.makeConstraints { make in
            make.top.equalTo(documentNumberTextField.snp.bottom).offset(Size.smallS)
            make.leading.trailing.equalToSuperview().inset(Size.middleS)
        }
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(Size.middleS)
            make.trailing.equalToSuperview().offset(-Size.middleS)
        }
        forwardButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(Size.smallL)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Size.middleS)
            make.height.equalTo(Size.largeXL)
        }
        letRegisterButton.snp.makeConstraints { make in
            make.top.equalTo(forwardButton.snp.bottom).offset(Size.smallL)
            make.leading.equalTo(view.snp.centerX)
        }
        noAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(forwardButton.snp.bottom).offset(Size.smallXL)
            make.trailing.equalTo(view.snp.centerX).offset(-Size.smallS)
        }
    }
}

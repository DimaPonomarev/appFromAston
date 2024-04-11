//
//  CustomTextField.swift
//  BettaBank
//
//  Created by Dmitry Gorbunow on 10/29/23.
//

import Foundation
import UIKit

enum CustomTextFieldType {
    case phone
    case email
    case document
    case password
    case appPassword
}

// MARK: - Constants

// TODO: взять из метрик
private extension CGFloat {
    static let averageFontSize = 16.0
    static let cornerRadius = 8.0
    static let offset24 = 24.0
    static let mainWidth = 40.0
}

// TODO: взять из Общего файла стрингов
enum CustomTextFieldPlaceholder {
    static let enterOldPassword = "Введите старый пароль"
    static let enterNewPassword = "Введите новый пароль"
    static let repeatNewPassword = "Повторите новый пароль"
}

class CustomTextField: UITextField {

    private var isPasswordVisible = false
    private let authFieldType: CustomTextFieldType
    private let showPasswordButton = UIButton(type: .custom)

    // MARK: - init

    init(fieldType: CustomTextFieldType, placeholder: String) {
        self.authFieldType = fieldType
        super.init(frame: .zero)
        
        self.backgroundColor = .textField
        self.tintColor = .yellowButtonColor
        self.layer.cornerRadius = .cornerRadius
        self.font = UIFont.systemFont(ofSize: .averageFontSize, weight: .medium)
        self.clearButtonMode = .always
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: .offset24, height: self.frame.size.height))
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.textFieldPlaceholder]
        )
        
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(named: "clearButton"), for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: .offset24, height: .offset24)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: .mainWidth, height: .offset24))
        
        switch fieldType {
        case .phone:
            self.keyboardType = .phonePad
            self.rightView = paddingView
            self.rightViewMode = .whileEditing
            self.clearButtonMode = .never
            paddingView.addSubview(clearButton)
        case .email:
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
            self.rightView = paddingView
            self.rightViewMode = .whileEditing
            self.clearButtonMode = .never
            paddingView.addSubview(clearButton)
        case .document:
            self.keyboardType = .numberPad
            self.rightView = paddingView
            self.rightViewMode = .whileEditing
            self.clearButtonMode = .never
            paddingView.addSubview(clearButton)
        case .password:
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
            self.rightViewMode = .always
            showPasswordButton.setImage(UIImage(named: "hidePassword"), for: .normal)
            showPasswordButton.frame = CGRect(x: 0, y: 0, width: .offset24, height: .offset24)
            showPasswordButton.contentMode = .scaleAspectFit
            showPasswordButton.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)
            paddingView.addSubview(showPasswordButton)
            self.rightView = paddingView
        case .appPassword:
            self.keyboardType = .phonePad
            self.rightViewMode = .whileEditing
            self.clearButtonMode = .never
            self.isSecureTextEntry = true
            self.rightViewMode = .always
            showPasswordButton.setImage(UIImage(named: "hidePassword"), for: .normal)
            showPasswordButton.frame = CGRect(x: 0, y: 0, width: .offset24, height: .offset24)
            showPasswordButton.contentMode = .scaleAspectFit
            showPasswordButton.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)
            paddingView.addSubview(showPasswordButton)
            self.rightView = paddingView
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - @objc Methods

    @objc func clearText() {
        self.text = ""
    }
    
    @objc func showPasswordButtonTapped() {
        isPasswordVisible.toggle()
        self.isSecureTextEntry = !isPasswordVisible
        
        let imageName = isPasswordVisible ? "showPassword" : "hidePassword"
        showPasswordButton.setImage(UIImage(named: imageName), for: .normal)
    }
}

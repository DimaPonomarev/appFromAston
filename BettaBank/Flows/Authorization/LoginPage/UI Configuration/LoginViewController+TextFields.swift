//
//  LoginViewController+TextFields.swift
//  BettaBank
//
//  Created by Dzhami on 08.12.2023.
//

import UIKit

// TODO: унифицировать конструкторы textFields через CustomTextField

extension LoginViewController {
    // MARK: - TextFields Setup
    
     func configureTextFields() {
        phoneTextField.delegate = self
        passwordTextField.delegate = self
        documentNumberTextField.delegate = self
        phoneTextField.layer.cornerRadius = Size.smallM
        passwordTextField.layer.cornerRadius = Size.smallM
        documentNumberTextField.layer.cornerRadius = Size.smallM
        phoneTextField.addTarget(self, action: #selector(phoneTextFieldDidChange), for: .editingChanged)
        documentNumberTextField.addTarget(self, action: #selector(documentNumberTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        
        let clearPhoneNumberButton = createClearButton(for: self, action: #selector(clearPhoneTextField))
        configureTextField(phoneTextField, placeholder: TextLabels.LoginVC.phoneNumber, clearButton: clearPhoneNumberButton)
        phoneTextField.keyboardType = .phonePad
        
        let clearDocumentNumberButton = createClearButton(for: self, action: #selector(clearDocumentNumberTextField))
        configureTextField(documentNumberTextField, placeholder: TextLabels.LoginVC.email, clearButton: clearDocumentNumberButton)
        documentNumberTextField.keyboardType = .emailAddress
        documentNumberTextField.autocapitalizationType = .none
        
        configureTextField(passwordTextField, placeholder: TextLabels.LoginVC.password, isSecure: true)
        passwordTextField.layoutIfNeeded()
    }
    
     func showPhoneTextField() {
        phoneTextField.isHidden = false
        documentNumberTextField.isHidden = true
        documentNumberTextField.text = ""
        warningDocumentLabel.text = ""
    }
    
     func showDocumentNumberTextField() {
        phoneTextField.isHidden = true
        documentNumberTextField.isHidden = false
        phoneTextField.text = ""
        warningPhoneLabel.text = ""
    }
}

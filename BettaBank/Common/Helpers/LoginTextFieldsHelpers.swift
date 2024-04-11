//
//  LoginTextFieldsHelpers.swift
//  BettaBank
//
//  Created by Борис Кравченко on 09.11.2023.
//

 // TODO: унифицировать конструкторы textFields
import UIKit

func createClearButton(for target: Any, action: Selector) -> UIButton {
    let clearButton = UIButton(type: .custom)
    clearButton.setImage(UIImage(resource: .clearButton), for: .normal)
    clearButton.contentMode = .scaleAspectFit
    clearButton.tintColor = .gray
    clearButton.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
    clearButton.configuration = .plain()
    clearButton.configuration?.baseBackgroundColor = .clear
    clearButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
    clearButton.addTarget(target, action: action, for: .touchUpInside)
    return clearButton
}

func configureTextField(
    _ textField: UITextField,
    placeholder: String,
    clearButton: UIButton? = nil,
    isSecure: Bool = false
) {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .left
    paragraphStyle.firstLineHeadIndent = 16

    textField.attributedPlaceholder = NSAttributedString(
        string: placeholder,
        attributes: [
            .font: UIFont.systemFont(ofSize: 18),
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.gray
        ]
    )
    textField.backgroundColor = .systemGray6
    textField.borderStyle = .roundedRect
    textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
    textField.defaultTextAttributes = [
        .font: UIFont.systemFont(ofSize: 18, weight: .regular),
        .foregroundColor: UIColor.black,
        .paragraphStyle: paragraphStyle
    ]
    
    if let clearButton = clearButton {
        textField.rightView = clearButton
        textField.rightViewMode = .whileEditing
    }
    
    if isSecure {
        let passwordToggle = PasswordToggleButton(passwordTextField: textField)
                textField.isSecureTextEntry = true
                textField.rightView = passwordToggle
                textField.rightViewMode = .always
    }
}

//
//  PasswordToggleButton.swift
//  BettaBank
//
//  Created by Борис Кравченко on 09.11.2023.
//

// TODO: унифицировать конструкторы textFields через CustomTextField
import UIKit

class PasswordToggleButton: UIButton {
    var isPasswordHidden: Bool = true {
        didSet {
            guard let text = passwordTextField else { return }
            text.isSecureTextEntry = isPasswordHidden
        }
    }

    private weak var passwordTextField: UITextField?

    init(passwordTextField: UITextField) {
        super.init(frame: .zero)
        self.passwordTextField = passwordTextField
        setImage(UIImage(resource: .hidePassword), for: .normal)
        setImage(UIImage(resource: .showPassword), for: .selected)
        tintColor = .gray
        addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        self.configuration = .plain()
        self.configuration?.baseBackgroundColor = .clear
        self.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        isHidden = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc func togglePasswordVisibility() {
        isPasswordHidden.toggle()
        isSelected = !isPasswordHidden
    }
    
    @objc func textFieldDidChange() {
        isHidden = passwordTextField?.text?.isEmpty ?? true
    }
}

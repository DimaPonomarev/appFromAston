//
//  ChangeEmailViewController.swift
//  BettaBank
//
//  Created by Dzhami on 14.12.2023.
//

import UIKit

final class ChangeEmailViewController: UIViewController {
    
    //  MARK: - External dependencies
    
    private let viewModel: ChangeEmailViewModelProtocol
    private var originalEmail: String?

    //  MARK: - UI properties
    
    private let label = UILabel()
    private let textField = UITextField()
    private let warningLabel = UILabel()
    private let saveButton = PersonalAccountCustomButton()
    
    //  MARK: - init
    
    init(viewModel: ChangeEmailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        activateKeyboardRemoval()
    }
    
    override func viewDidLayoutSubviews() {
        textField.underlined()
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
        updateSaveButtonState()
    }
    
    private func addViews() {
        [label, textField, saveButton, warningLabel].forEach { view.addSubview($0)}
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.itemBackgroundColor
        textField.delegate = self
        
        self.title = TextLabels.Demo.emailPlaceholder
        label.text = TextLabels.Demo.enterEmail
        label.font = Font.boldMiddleM
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        textField.placeholder = TextLabels.Demo.emailPlaceholder
        
        setupBackNavigationButton(type: .changeEmail) { [weak self] in
                self?.showAlertIfEmailNotSaved()
        }
        
        warningLabel.textColor = .red
        warningLabel.textAlignment = .left
        warningLabel.font = Font.regularSmallXL
        warningLabel.minimumScaleFactor = 0.5
        warningLabel.adjustsFontSizeToFitWidth = true
        warningLabel.text = TextLabels.Demo.wrongEmail
        
        saveButton.setupButton(String.Demo.buttonSave, .yellow)
        saveButton.addTarget(self, action: #selector(onSaveButtonTap), for: .touchDown)
    }
    
    private func setupConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Size.largeXL)
            make.centerX.equalToSuperview()
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(Size.middleXL)
            make.leading.trailing.equalToSuperview().offset(Size.smallXL)
        }
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(Size.smallM)
            make.leading.trailing.equalToSuperview().offset(Size.smallXL)
        }
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(Size.smallXL)
            make.leading.trailing.equalToSuperview().inset(Size.smallXL)
            make.height.equalTo(saveButton.intrinsicContentSize.height + Size.smallM)
        }
    }
    
    //  MARK: - private methods
    
    private func activateKeyboardRemoval() {
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func updateSaveButtonState() {
        let email = textField.text ?? ""
        let isEmailValid = Validator.isValidEmail(email)
        let isTextFieldEmpty = textField.text?.isEmpty ?? true
        
        saveButton.isEnabled = !isTextFieldEmpty && isEmailValid
        
        if saveButton.isEnabled {
            saveButton.backgroundColor = .yellow
            warningLabel.isHidden = true
        } else {
            saveButton.backgroundColor = .gray
            warningLabel.isHidden = isTextFieldEmpty
        }
    }
    
    private func showAlertIfEmailNotSaved() {
        originalEmail = "Hello@world.com" // захардкоден email для проверки
        
        guard let originalEmail = originalEmail, let currentEmail = textField.text else { return }
        
        if originalEmail != currentEmail {
            let alert = UIAlertController(
                title: TextLabels.Alert.backToSettings,
                message: TextLabels.Alert.unsavedChangesConfirmationMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: TextLabels.Alert.cancelAction, style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: TextLabels.Alert.continueAction, style: .default, handler: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true) }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    //  MARK: - @objc
    
    @objc private func onSaveButtonTap() {
        originalEmail = textField.text  // добавить логику сохранения
    }
}

//  MARK: - Extension

extension ChangeEmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        updateSaveButtonState()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
}

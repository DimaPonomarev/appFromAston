//
//  OneTimeCodeTextField.swift
//  BettaBank
//
//  Created by Dmitry Gorbunow on 11/5/23.
//

import UIKit

// MARK: - Constants

// TODO: взять из метрик
private extension CGFloat {
    static let averageFontSize = 16.0
    static let stackSpacing = 13.0
    static let cornerRadius = 8.0
}

private enum Constants {
    static let slotCount: Int = 6
}

class OneTimeCodeTextField: UITextField {

    // MARK: - Properties

    var didEnterLastDigit: ((String) -> Void)?
    private var isConfigured = false
    private var digitLabels = [UILabel]()

    // MARK: - UI Components

    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector (becomeFirstResponder))
        return recognizer
    }()

    // MARK: - Private Methods

    private func configureTextField() {
        tintColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        textContentType = .oneTimeCode
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        delegate = self
    }
    
    private func createLabelsStackView(with count: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = .stackSpacing
        
        for _ in 1...count {
            let label = UILabel()
            label.textAlignment = .center
            label.font = .systemFont(ofSize: .averageFontSize)
            label.layer.cornerRadius = .cornerRadius
            label.clipsToBounds = true
            label.isUserInteractionEnabled = true
            label.backgroundColor = .systemGray6
            stackView.addArrangedSubview(label)
            digitLabels.append(label)
        }
        return stackView
    }

    // MARK: - Public Methods

    func configure(with slotCount: Int = Constants.slotCount) {
        guard isConfigured == false else { return }
        isConfigured.toggle()
        
        configureTextField()
        
        let labelsStackView = createLabelsStackView(with: slotCount)
        addSubview(labelsStackView)
        
        addGestureRecognizer(tapRecognizer)
        
        labelsStackView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }

    // MARK: - objc Methods

    @objc private func textDidChange() {
        guard let text = self.text, text.count <= digitLabels.count else { return }
        for eachLabel in 0..<digitLabels.count {
            let currentLabel = digitLabels[eachLabel]
            if eachLabel < text.count {
                let index = text.index(text.startIndex, offsetBy: eachLabel)
                currentLabel.text = String(text[index])
            } else {
                currentLabel.text?.removeAll()
            }
        }
        
        if text.count == digitLabels.count {
            didEnterLastDigit?(text)
        }
    }
}

// MARK: - UITextFieldDelegate

extension OneTimeCodeTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let characterCount = textField.text?.count else { return false }
        return characterCount < digitLabels.count || string == ""
    }
}

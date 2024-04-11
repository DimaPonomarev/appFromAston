//
//  CustomButton.swift
//  BettaBank
//
//  Created by Dmitry Gorbunow on 11/7/23.
//

import UIKit

// MARK: - Constants

// TODO: - взять из метрик
private extension CGFloat {
    static let cornerRadius = 8.0
    static let borderWidth = 0.3
    static let averageFontSize = 16.0
    static let littleFontSize = 12.0
}

// TODO: Вынести из класса
class CustomButton: UIButton {
    
    enum ButtonSize {
        case big
        case small
    }

    // MARK: - init

    init(title: String, hasBackground: Bool = false, size: ButtonSize) {
        super.init(frame: .zero)
        
        switch size {
        case .big:
            self.setTitle(title, for: .normal)
            self.layer.cornerRadius = .cornerRadius
            self.backgroundColor = .grayButton
            self.layer.borderWidth = .borderWidth
            self.layer.borderColor = UIColor.buttonBorder.cgColor
            self.titleLabel?.font = UIFont.systemFont(ofSize: .averageFontSize, weight: .bold)
            self.setTitleColor(.textFieldPlaceholder, for: .normal)
        case .small:
            self.setTitle(title, for: .normal)
            self.titleLabel?.font = UIFont.systemFont(ofSize: .littleFontSize, weight: .regular)
            self.setTitleColor(.blueButton, for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

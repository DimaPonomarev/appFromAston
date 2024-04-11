//
//  MainScreenButton.swift
//  MRN Coordinator
//
//  Created by Margarita Slesareva on 02.11.2023.
//

import UIKit

private enum Constants {
    static let contentInsets: NSDirectionalEdgeInsets = .init(top: 12, leading: 0, bottom: 12, trailing: 0)
    static let borderWidth: CGFloat = 2
}

enum Style {
    case primary
    case secondary
    case text
}

final class BaseButton: UIButton {
    
    private var style: Style
    
    init(style: Style) {
        self.style = style
        
        super.init(frame: .zero)
        
        configure()
        styleConfigire()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func setTitle(text: String) {
        setTitle(text, for: .normal)
    }
    
    private func configure() {
        layer.cornerRadius = Size.smallXL
        titleLabel?.font = Font.regularSmallXL
        
        configuration = .plain()
        configuration?.contentInsets = Constants.contentInsets
    }
    
    private func styleConfigire() {
        switch style {
        case .primary:
            backgroundColor = .yellowButtonColor
            setTitleColor(.textColor, for: .normal)
            tintColor = .lightGray
        case .secondary:
            setTitleColor(.textColor, for: .normal)
            layer.borderWidth = Constants.borderWidth
            layer.borderColor = UIColor.yellowButtonColor.cgColor
            tintColor = .lightGray
        case .text:
            setTitleColor(.textColor, for: .normal)
        }
    }
}

extension BaseButton {
    static var standardHeight: CGFloat { Size.largeXL }
}

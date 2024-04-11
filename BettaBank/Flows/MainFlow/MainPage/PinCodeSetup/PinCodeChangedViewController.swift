//
//  PinCodeChangedViewController.swift
//  BettaBank
//
//  Created by Vadim Blagodarny on 21.12.2023.
//

import UIKit
import SnapKit

private enum Constants {
    static let pinCodeChangedMessage = "PIN-код карты\nуспешно изменен"
    static let pinCodeChangedLines = 2
}

final class PinCodeChangedViewController: UIViewController {
        
    // MARK: - UI properties
    
    private let messageLabel = UILabel()
    
    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
    }
        
    private func addViews() {
        view.addSubview(messageLabel)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        setupBackNavigationButton(type: .pop)
        messageLabel.font = Font.mediumMiddleM
        messageLabel.text = Constants.pinCodeChangedMessage
        messageLabel.numberOfLines = Constants.pinCodeChangedLines
        messageLabel.textAlignment = .center
    }
        
    private func setupConstraints() {
        messageLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

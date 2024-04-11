//
//  WelcomeViewController.swift
//  MRN Coordinator
//
//  Created by Margarita Slesareva on 01.11.2023.
//

import UIKit
import SnapKit

private enum Constants {
    static let greetingNumberOfLines: Int = 2
    static let preloaderHeight: CGFloat = 132
    static let preloaderCenterYMultiply: CGFloat = 1.3
}

final class WelcomeViewController: UIViewController {
    private let welcomeViewModel: WelcomeScreenViewModel
    
    private let greetingLabel = UILabel()
    private let welcomeView = WelcomeView()
    private let loginButton = BaseButton(style: .primary)
    private let demoButton = BaseButton(style: .secondary)

    init(welcomeViewModel: WelcomeScreenViewModel) {
        self.welcomeViewModel = welcomeViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        addViews()
        addConstraints()
        configureViews()
    }
    
    private func addViews() {
        [greetingLabel, welcomeView, loginButton, demoButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func addConstraints() {
        greetingLabel.snp.makeConstraints { make in
            make.horizontalEdges.greaterThanOrEqualToSuperview().inset(Size.middleXL)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Size.middleM)
            make.centerX.equalToSuperview()
        }
        
        welcomeView.snp.makeConstraints { make in
            make.top.equalTo(greetingLabel.snp.bottom).offset(Size.middleM)
            make.horizontalEdges.greaterThanOrEqualToSuperview().inset(Size.smallXL)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Size.smallXL)
            make.top.greaterThanOrEqualTo(welcomeView.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Size.middleM)
        }
        
        demoButton.snp.makeConstraints { make in
            make.leading.equalTo(loginButton.snp.trailing).offset(Size.smallXL)
            make.bottom.equalTo(loginButton.snp.bottom)
            make.trailing.equalToSuperview().inset(Size.smallXL)
            make.width.equalTo(loginButton.snp.width)
        }
    }
    
    private func configureViews() {
        view.backgroundColor = .mainBackgroundColor
        
        greetingLabel.text = "Добро пожаловать в Бэтта Банк!".localized()
        greetingLabel.numberOfLines = Constants.greetingNumberOfLines
        greetingLabel.textColor = .textColor
        greetingLabel.font = Font.mediumMiddleM
        greetingLabel.textAlignment = .center
        
        loginButton.setTitle(text: "Войти".localized())
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        demoButton.setTitle("Демо".localized(), for: .normal)
        demoButton.addTarget(self, action: #selector(demoButtonTapped), for: .touchUpInside)
    }
        
    @objc private func loginButtonTapped() {
        welcomeViewModel.loginButtonTapped()
    }
    
    @objc private func demoButtonTapped() {
        welcomeViewModel.demoButtonTapped()
    }
}

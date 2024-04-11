//
//  AppPasswordWasChangedViewController.swift
//  BettaBank
//
//  Created by Борис Кравченко on 16.12.2023.
//

import UIKit
import SnapKit

private extension CGFloat {
    static let offset48 = 48.0
}

final class AppPasswordWasChangedViewController: UIViewController {
    
    func goToChangePasswordScreen() {}
    func goToNotificationSettingsScreen() {}
    func goToMainPage() {}
    private let viewModel: AppPasswordWasChangedViewModelProtocol

    // MARK: - Properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(resource: "appPasswordWasChanged")
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.ChangingAppPassword.passwordWasChangedSuccessfully
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.font = Font.boldMiddleXL
        return label
    }()
    
    private let continueButton = CustomButton(title: TextLabels.ChangingAppPassword.toMain, size: .big)
    
    private func setupContinueButton() {
        continueButton.backgroundColor = .yellowButtonColor
        continueButton.setTitleColor(.black, for: .normal)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }

    // MARK: - init
    init(viewModel: AppPasswordWasChangedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupContinueButton()
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        title = TextLabels.ChangingAppPassword.titleOfVC
        
        setupBackNavigationButton(type: .pop)
        
        view.addSubview(imageView)
        view.addSubview(descriptionLabel)
        view.addSubview(continueButton)
        
        setupConstraints()
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().dividedBy(1.5)
            make.left.right.equalToSuperview().inset(Size.smallXL)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(-Size.middleXL)
            make.left.right.equalToSuperview().inset(Size.smallXL)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(Size.smallXL)
            make.leading.trailing.equalToSuperview().inset(Size.smallXL)
            make.height.equalTo(CGFloat.offset48)
        }
    }

    // MARK: - @objc Methods
    
    @objc private func continueButtonTapped() {
        viewModel.toMainDidTapped()
    }
}

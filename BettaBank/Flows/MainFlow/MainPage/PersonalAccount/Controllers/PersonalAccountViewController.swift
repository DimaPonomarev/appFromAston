//
//  File.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 29.11.2023.
//

import UIKit

private enum Constants {
    static let profileImageSize = 200
}

final class PersonalAccountViewController: UIViewController {
    
    private let viewModel: PersonalAccountViewModel

    //  MARK: - UI properties
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let profileImageView = UIImageView()
    private let infoStackView = UIStackView()
    private let userNameView = PersonalAccountInfoOnWhiteBackgroundView()
    private let passportDataView = PersonalAccountInfoOnWhiteBackgroundView()
    private let emailInfoView = PersonalAccountInfoOnWhiteBackgroundView()
    private let telephoneNumberInfoView = PersonalAccountInfoOnWhiteBackgroundView()
    private let changePasswordView = PersonalAccountInfoOnWhiteBackgroundView()
    private let setupNotificationsView = PersonalAccountInfoOnWhiteBackgroundView()
    private let saveButton = PersonalAccountCustomButton()
    
    //  MARK: - init
    
    init(viewModel: PersonalAccountViewModel) {
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
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
        setupBackNavigationButton(type: .pop)
    }
        
    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(profileImageView)
        contentView.addSubview(infoStackView)
        infoStackView.addArrangedSubview(userNameView)
        infoStackView.addArrangedSubview(passportDataView)
        infoStackView.addArrangedSubview(emailInfoView)
        infoStackView.addArrangedSubview(telephoneNumberInfoView)
        infoStackView.addArrangedSubview(changePasswordView)
        infoStackView.addArrangedSubview(setupNotificationsView)
        view.addSubview(saveButton)
    }
    
    private func setupViews() {
        self.title = String.Demo.personalAccaunt
        view.backgroundColor = UIColor.itemBackgroundColor
        
        infoStackView.axis = .vertical
        infoStackView.distribution = .fillProportionally
        infoStackView.spacing = 5
      
        profileImageView.image = UIImage(resource: .profileCircle)
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = Size.middleXL
        profileImageView.layer.shadowPath = UIBezierPath(roundedRect: profileImageView.layer.bounds, cornerRadius: 0).cgPath
        profileImageView.layer.shadowRadius = Size.smallS
        profileImageView.clipsToBounds = true
        
        userNameView.setupViewsOnWhiteBackground(title: String.Demo.userName, content: String.Demo.exampleUserName)
        passportDataView.setupViewsOnWhiteBackground(title: String.Demo.passportData)
        emailInfoView.setupViewsWithoutBackground(title: String.Demo.email, content: String.Demo.exampleOfEmail)
        telephoneNumberInfoView.setupViewsWithoutBackground(title: String.Demo.phoneNumber, content: String.Demo.exampleOfPhoneNumber)
        changePasswordView.setupViewsOnWhiteBackground(title: String.Demo.changePassword)
        setupNotificationsView.setupViewsOnWhiteBackground(title: String.Demo.setupNotifications)
        
        setupNotificationsView.onViewDidTap = {[weak self] in
            self?.viewModel.notificationViewDidTapped()
        }
        
        changePasswordView.onViewDidTap = {[weak self] in
            self?.viewModel.changePasswordViewDidTapped()
        }
        
        saveButton.setupButton(String.Demo.buttonSave, .yellow)
        saveButton.addTarget(self, action: #selector(onSaveButtonTap), for: .touchDown)
        
    }
        
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.width.equalToSuperview()
            make.bottom.equalTo(saveButton.snp.top).inset(-Size.smallM)
        }
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.size.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
        }
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Size.middleM)
            make.centerX.equalToSuperview()
            make.size.equalTo(Constants.profileImageSize)
        }
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(Size.middleM)
            make.leading.trailing.equalToSuperview().inset(Size.smallXL)
        }
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(Size.smallXL)
            make.leading.trailing.equalToSuperview().inset(Size.smallXL)
            make.height.equalTo(saveButton.intrinsicContentSize.height + Size.smallM)
        }
    }
    
//    MARK: - objc func
    
    @objc private func onSaveButtonTap() {
        navigationController?.dismiss(animated: true)
    }
}

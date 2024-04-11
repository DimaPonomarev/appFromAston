//
//  NotificationsSettingsViewController.swift
//  BettaBank
//
//  Created by Dzhami on 13.12.2023.
//

import UIKit

final class NotificationSettingsViewController: UIViewController {
    
    //  MARK: - External dependencies
    
    private let viewModel: NotificationSettingsViewModelProtocol
    
    //  MARK: - UI properties
    
    private let emailView = NotificationSettingsView()
    private let smsView = NotificationSettingsView()
    private let pushView = NotificationSettingsView()
    private let emailMailingView = NotificationSettingsView()
    
    //  MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setUpViews()
        setupConstraints()
    }
    
    // MARK: - init
    
    init(viewModel: NotificationSettingsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - setup UI
    
    private func addViews() {
        [emailView, smsView, pushView, emailMailingView].forEach { view.addSubview($0)}
    }
    
    private func setUpViews() {
        view.backgroundColor = UIColor.itemBackgroundColor
        self.title = TextLabels.Demo.notifications
        setupBackNavigationButton(type: .pop)
        
        emailView.onSwitchTap = { [weak self] in
            self?.viewModel.emailDidTapped()
        }
        
        emailView.configure(
            icon: UIImage(resource: .envelope), title: TextLabels.Demo.emailPlaceholder, showEditButton: true)
        smsView.configure(
            icon: UIImage(resource: .sms), title: TextLabels.Demo.smsNotifications, showEditButton: false)
        pushView.configure(
            icon: UIImage(resource: .ringingBell), title: TextLabels.Demo.pushNotifications, showEditButton: false)
        emailMailingView.configure(
            icon: UIImage(resource: .sendEnvelope), title: TextLabels.Demo.emailMailing, showEditButton: false)
    }
    
    private func setupConstraints() {
        emailView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Size.smallXL)
            make.leading.trailing.equalToSuperview().inset(Size.smallXL)
        }
        smsView.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(Size.smallXL)
            make.leading.trailing.equalToSuperview().inset(Size.smallXL)
        }
        pushView.snp.makeConstraints { make in
            make.top.equalTo(smsView.snp.bottom).offset(Size.smallXL)
            make.leading.trailing.equalToSuperview().inset(Size.smallXL)
        }
        emailMailingView.snp.makeConstraints { make in
            make.top.equalTo(pushView.snp.bottom).offset(Size.smallXL)
            make.leading.trailing.equalToSuperview().inset(Size.smallXL)
        }
    }
}

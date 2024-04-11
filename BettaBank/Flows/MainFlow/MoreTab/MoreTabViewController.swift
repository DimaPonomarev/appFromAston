//
//  DemoMoreTabViewController.swift
//  BettaBank
//
//  Created by Vadim Blagodarny on 05.12.2023.
//

import UIKit
import SnapKit

private enum Constants {
    static let securityText = "Безопасность"
    static let privacyText = "Политика конфиденциальности"
    static let personalDataText = "Хранение персональных данных"
    static let sbdoText = "СБДО"
    static let contactsText = "Контакты"
    static let locationText = "Адреса банков на карте"
    
    static let userNameText = "Ирина"
    static let versionText = "Версия 1.0"
    static let updateText = "Обновлено 12.01.22"
    
    static let exitButtonTitle = "Выход"
    
    static let primaryTextColor = UIColor(red: 0.075, green: 0.075, blue: 0.075, alpha: 1)
    static let secondaryTextColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 0.5)
    static let exitButtonBGColor = UIColor(red: 0.922, green: 0.922, blue: 0.922, alpha: 1)
    
    static let itemButtomInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: -12)
    static let itemSpacing = CGFloat(28)
    
    static let smallIconSize = CGSize(width: 24, height: 24)
}

private struct MoreTabModel {
    let title: String
    let closure: () -> Void
}

final class MoreTabViewController: UIViewController {
    
    // MARK: - external dependencies
    
    private let viewModel: MoreTabViewModelProtocol
    
    // MARK: - UI properties
    
    private let userImageView = UIImageView()
    private let userNameLabel = UILabel()
    private let itemsStackView = UIStackView()
    private let versionImageView = UIImageView()
    private let versionLabel = UILabel()
    private let updateLabel = UILabel()
    private let exitButton = UIButton()
    
    // MARK: - private properties
    
    private lazy var buttonModels = [MoreTabModel(title: Constants.securityText,
                                                  closure: { [weak self] in
    }),
                                     MoreTabModel(title: Constants.privacyText,
                                                  closure: { [weak self] in
        self?.viewModel.privacyPolicyButtonTapped()
    }),
                                     MoreTabModel(title: Constants.personalDataText,
                                                  closure: { [weak self] in
        self?.viewModel.dataStorageButtonTapped()
    }),
                                     MoreTabModel(title: Constants.sbdoText,
                                                  closure: { [weak self] in
        self?.viewModel.termOfUseButtonTapped()
    }),
                                     MoreTabModel(title: Constants.contactsText,
                                                  closure: { [weak self] in
        self?.viewModel.showContactsTapped()
    }),
                                     MoreTabModel(title: Constants.locationText,
                                                  closure: { [weak self] in
        self?.viewModel.showLocationTapped()
    })]
    
    let buttons = [UIButton()]
    
    // MARK: - init
    
    init(viewModel: MoreTabViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupItems()
        setupConstraints()
    }
    
    private func addViews() {
        let views = [userImageView,
                     userNameLabel,
                     itemsStackView,
                     versionImageView,
                     versionLabel,
                     updateLabel,
                     exitButton]
        
        views.forEach { [weak self] view in
            self?.view.addSubview(view)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        userImageView.image = UIImage(resource: .userIcon)
        
        userNameLabel.text = Constants.userNameText
        userNameLabel.font = Font.mediumMiddleM
        userNameLabel.textColor = Constants.primaryTextColor
        
        itemsStackView.axis = .vertical
        itemsStackView.alignment = .leading
        itemsStackView.spacing = Constants.itemSpacing
        
        versionImageView.image = UIImage(resource: .infoIcon).resized(to: Constants.smallIconSize)
        
        versionLabel.text = Constants.versionText
        versionLabel.font = Font.regularSmallXL
        versionLabel.textColor = Constants.secondaryTextColor
        
        updateLabel.text = Constants.updateText
        updateLabel.font = Font.regularSmallXL
        updateLabel.textColor = Constants.secondaryTextColor
        
        exitButton.setTitle(Constants.exitButtonTitle, for: .normal)
        exitButton.setTitleColor(Constants.primaryTextColor, for: .normal)
        exitButton.backgroundColor = Constants.exitButtonBGColor
        exitButton.titleLabel?.font = Font.boldSmallXL
        exitButton.layer.cornerRadius = Size.smallM
        exitButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            viewModel.exitButtonTapped()
        }), for: .touchUpInside)
    }
    
    private func setupItems() {
        buttonModels.forEach { model in
            let button = UIButton(primaryAction: UIAction(handler: { _ in
                model.closure()
            }))
            
            let icon = UIImage(resource: .loanIcon)
                .resized(to: Constants.smallIconSize)
            
            button.setTitle(model.title, for: .normal)
            button.titleLabel?.font = Font.mediumSmallXL
            button.setImage(icon, for: .normal)
            button.titleEdgeInsets = Constants.itemButtomInsets
            button.tintColor = Constants.primaryTextColor
            
            itemsStackView.addArrangedSubview(button)
        }
    }
    
    private func setupConstraints() {
        userImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Size.middleM)
            make.leading.equalToSuperview().offset(Size.smallXL)
            make.size.equalTo(Size.middleXL)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView)
            make.leading.equalTo(userImageView.snp.trailing).offset(Size.smallXL)
        }
        
        itemsStackView.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(Size.middleXL)
            make.leading.equalToSuperview().offset(Size.smallXL)
            make.trailing.equalToSuperview().inset(Size.smallXL)
        }
        
        versionImageView.snp.makeConstraints { make in
            make.top.equalTo(itemsStackView.snp.bottom).offset(Size.middleXL)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        
        versionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(versionImageView.snp.centerY)
            make.leading.equalTo(versionImageView.snp.trailing).offset(Size.smallL)
        }
        
        updateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(versionLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(Size.smallL)
        }
        
        exitButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Size.middleS)
            make.leading.equalToSuperview().offset(Size.middleS)
            make.trailing.equalToSuperview().inset(Size.middleS)
            make.height.equalTo(Size.largeXL)
        }
    }
}

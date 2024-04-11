//
//  DemoContactsViewController.swift
//  BettaBank
//
//  Created by Vadim Blagodarny on 30.11.2023.
//

import UIKit
import SnapKit

private enum Constants {
    static let fatalError = "init(coder:) has not been implemented"
    static let phoneOneText = "3700"
    static let phoneOneDescription = "Короткий номер"
    static let phoneTwoText = "+7 888 654 7891"
    static let phoneTwoDescription = "Номер для международных звонков"
    static let emailText = "info@bettabank.ru"
    static let locationText = "Банкоматы и отделения"
    static let socialNetworksText = "Социальные сети и мессенджеры"
    static let oneHalfMultiplier = 0.5
    static let separatorLineHeight = 2
}

final class ContactsViewController: UIViewController {
        
    // MARK: - UI properties
    
    private let phoneOneImageView = UIImageView()
    private let phoneOneLabel = UILabel()
    private let phoneOneDescriptionLabel = UILabel()
    private let phoneTwoImageView = UIImageView()
    private let phoneTwoLabel = UILabel()
    private let phoneTwoDescriptionLabel = UILabel()
    private let emailImageView = UIImageView()
    private let emailLabel = UILabel()
    private let locationImageView = UIImageView()
    private let locationLabel = UILabel()
    private let separatorLine = UIView()
    private let socialNetworksLabel = UILabel()
    private let vkButton = UIButton()
    private let youtubeButton = UIButton()
    private let telegramButton = UIButton()
    
    // MARK: - life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupSocialNetworksViews()
        setupConstraints()
        setupSocialNetworksConstraints()
    }
        
    private func addViews() {
        view.addSubview(phoneOneImageView)
        view.addSubview(phoneOneLabel)
        view.addSubview(phoneOneDescriptionLabel)
        view.addSubview(phoneTwoImageView)
        view.addSubview(phoneTwoLabel)
        view.addSubview(phoneTwoDescriptionLabel)
        view.addSubview(emailImageView)
        view.addSubview(emailLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(separatorLine)
        view.addSubview(socialNetworksLabel)
        view.addSubview(vkButton)
        view.addSubview(youtubeButton)
        view.addSubview(telegramButton)
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.itemBackgroundColor
        
        phoneOneImageView.image = UIImage(resource: .phone)
        
        phoneOneLabel.text = Constants.phoneOneText
        phoneOneLabel.font = Font.regularSmallXL
        phoneOneLabel.textColor = .black
        
        phoneOneDescriptionLabel.text = Constants.phoneOneDescription
        phoneOneDescriptionLabel.font = Font.regularSmallL
        phoneOneDescriptionLabel.textColor = .darkGray
        
        phoneTwoImageView.image = UIImage(resource: .phone)
        
        phoneTwoLabel.text = Constants.phoneTwoText
        phoneTwoLabel.font = Font.regularSmallXL
        phoneTwoLabel.textColor = .black
        
        phoneTwoDescriptionLabel.text = Constants.phoneTwoDescription
        phoneTwoDescriptionLabel.font = Font.regularSmallL
        phoneTwoDescriptionLabel.textColor = .darkGray
        
        emailImageView.image = UIImage(resource: .email)
        
        emailLabel.text = Constants.emailText
        emailLabel.font = Font.regularSmallXL
        emailLabel.textColor = .black
        
        locationImageView.image = UIImage(resource: .location)
        
        locationLabel.text = Constants.locationText
        locationLabel.font = Font.regularSmallXL
        locationLabel.textColor = .black
    }
    
    private func setupSocialNetworksViews() {
        separatorLine.backgroundColor = UIColor.lightGray
        
        socialNetworksLabel.text = Constants.socialNetworksText
        socialNetworksLabel.font = Font.regularSmallXL

        vkButton.setImage(UIImage(resource: .vk), for: .normal)
        vkButton.layer.cornerRadius = vkButton.circleButtonRadius
        
        youtubeButton.setImage(UIImage(resource: .youtube), for: .normal)
        youtubeButton.layer.cornerRadius = vkButton.circleButtonRadius

        telegramButton.setImage(UIImage(resource: .telegram), for: .normal)
        telegramButton.layer.cornerRadius = vkButton.circleButtonRadius
    }
        
    private func setupConstraints() {
        phoneOneImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Size.middleXL)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        
        phoneOneLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneOneImageView.snp.top)
            make.leading.equalTo(phoneOneImageView.snp.trailing).offset(Size.smallXL)
        }
        
        phoneOneDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneOneLabel.snp.bottom).offset(Size.smallS)
            make.leading.equalTo(phoneOneLabel)
        }
        
        phoneTwoImageView.snp.makeConstraints { make in
            make.top.equalTo(phoneOneDescriptionLabel.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        
        phoneTwoLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneTwoImageView)
            make.leading.equalTo(phoneTwoImageView.snp.trailing).offset(Size.smallXL)
        }
        
        phoneTwoDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneTwoLabel.snp.bottom).offset(Size.smallS)
            make.leading.equalTo(phoneTwoLabel)
        }
        
        emailImageView.snp.makeConstraints { make in
            make.top.equalTo(phoneTwoDescriptionLabel.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(emailImageView)
            make.leading.equalTo(emailImageView.snp.trailing).offset(Size.smallXL)
        }
        
        locationImageView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(Size.middleS)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(locationImageView)
            make.leading.equalTo(locationImageView.snp.trailing).offset(Size.smallXL)
        }
    }
    
    private func setupSocialNetworksConstraints() {
        separatorLine.snp.makeConstraints { make in
            make.height.equalTo(Constants.separatorLineHeight)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(locationLabel.snp.bottom).offset(Size.middleM)
        }
        
        socialNetworksLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom).offset(Size.middleM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        
        vkButton.snp.makeConstraints { make in
            make.top.equalTo(socialNetworksLabel.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }

        youtubeButton.snp.makeConstraints { make in
            make.top.equalTo(socialNetworksLabel.snp.bottom).offset(Size.smallM)
            make.leading.equalTo(vkButton.snp.trailing).offset(Size.smallXL)
        }

        telegramButton.snp.makeConstraints { make in
            make.top.equalTo(socialNetworksLabel.snp.bottom).offset(Size.smallM)
            make.leading.equalTo(youtubeButton.snp.trailing).offset(Size.smallXL)
        }
    }
}

private extension UIButton {
    var circleButtonRadius: CGFloat {
        bounds.size.width * Constants.oneHalfMultiplier
    }
}

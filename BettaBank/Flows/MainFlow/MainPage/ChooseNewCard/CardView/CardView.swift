//
//  CardView.swift
//  BettaBank
//
//  Created by Egor Kruglov on 16.11.2023.
//  Edited by Vadim Blagodarnyi on 15.12.2023.
//

import UIKit

final class CardView: UIView {
    
    // MARK: - External dependencies
    
    private let viewModel: CardViewModelProtocol
    
    // MARK: - Constants
    
    private let cardVendorLogoWidth: CGFloat = 52
    private let cardVendorLogoHeight: CGFloat = 16
    private let cardTypeImageHeight: CGFloat = 19
    private let cardTypeImageWidth: CGFloat = 80
    
    static let cardViewHeight: CGFloat = 210
    
    // MARK: - UI properties
    private let backgroundImageView = UIImageView()
    private let cardOptionLabel = UILabel()
    private let cardTypeImageView = UIImageView()
    private let cardChipImageView = UIImageView()
    private let cardBalanceLabel = UILabel()
    private let cardNumberLabel = UILabel()
    private let cardExpirationLabel = UILabel()
    private let cardVendorLogo = UIImageView()
    
    // MARK: - init
    
    init(viewModel: CardViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
    }
    
    private func addViews() {
        addSubview(backgroundImageView)
        addSubview(cardOptionLabel)
        addSubview(cardTypeImageView)
        addSubview(cardChipImageView)
        addSubview(cardBalanceLabel)
        addSubview(cardNumberLabel)
        addSubview(cardExpirationLabel)
        addSubview(cardVendorLogo)
    }
    
    private func setupViews() {
        layer.cornerRadius = Size.smallM

        backgroundImageView.image = setBackgroundImage()
        backgroundImageView.layer.cornerRadius = Size.smallM
        backgroundImageView.clipsToBounds = true

        cardOptionLabel.text = viewModel.cardData.cardOption.name
        cardOptionLabel.font = Font.mediumMiddleM
        cardOptionLabel.textColor = .white
        
        cardTypeImageView.image = setTypeCardImage()

        cardChipImageView.image = UIImage(resource: .chip)
        
        cardBalanceLabel.text = viewModel.cardData.balance
        cardBalanceLabel.textColor = .white
        cardBalanceLabel.font = Font.boldLargeM
        
        cardNumberLabel.text = viewModel.cardData.number
        cardNumberLabel.textColor = .white
        cardNumberLabel.font = Font.monospacedRegularSmallXL
        
        cardExpirationLabel.text = viewModel.cardData.expirationDate
        cardExpirationLabel.textColor = .white
        cardExpirationLabel.font = Font.boldSmallXL
        
        cardVendorLogo.contentMode = .scaleAspectFill
        cardVendorLogo.image = setVendorImage()
        
    }
    
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cardOptionLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(Size.smallXL)
        }
        
        cardTypeImageView.snp.makeConstraints { make in
            make.centerY.equalTo(cardOptionLabel.snp.centerY)
            make.leading.equalTo(cardOptionLabel.snp.trailing).offset(Size.smallXL)
            make.height.equalTo(cardTypeImageHeight)
            make.width.equalTo(cardTypeImageWidth)
        }
        
        cardChipImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        
        cardBalanceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(cardChipImageView.snp.centerY)
            make.trailing.equalToSuperview().inset(Size.smallXL)
        }

        cardNumberLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(Size.smallXL)
        }
        
        cardExpirationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(cardVendorLogo.snp.centerY)
            make.trailing.equalTo(cardVendorLogo.snp.leading).offset(-Size.smallXL)
        }
        
        cardVendorLogo.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(Size.smallXL)
            make.height.equalTo(cardVendorLogoHeight)
            make.width.equalTo(cardVendorLogoWidth)
        }
        
    }
    
    // MARK: - private methods
    
    private func setVendorImage() -> UIImage? {
        switch viewModel.cardData.cardVendor {
        case .visa:
            UIImage(resource: .visa)
        case .mastercard:
            UIImage(resource: .masterCard)
        case .mir:
            UIImage(resource: .mir)
        }
    }
    
    private func setBackgroundImage() -> UIImage {
        switch viewModel.cardData.cardOption {
        case .silver:
            return UIImage(resource: .smartSilver)
        case .gold:
            return UIImage(resource: .smartGold)
        case .platinum:
            return UIImage(resource: .smartPlatinum)
        case .creditSilver:
            return UIImage(resource: .smartSilverCredit)
        case .creditGold:
            return UIImage(resource: .smartGoldCredit)
        }
    }
    
    private func setTypeCardImage() -> UIImage {
        switch viewModel.cardData.cardType {
        case .debit:
            return UIImage(resource: .debitTypeIcon)
        case .credit:
            return UIImage(resource: .creditTypeIcon)
        }
    }
}

//
//  CustomCardView.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 24.01.2024.
//

import UIKit

private enum Constants {
    static let numberHiddenPart = "* * * *  0 0 0 0"
    static let cardTypeImageHeight: CGFloat = 19
    static let cardTypeImageWidth: CGFloat = 80
}

final class CustomCardView: UIView {
    
    // MARK: - ui elements
    private let backgroundImageView = UIImageView()
    private let cardTitleLabel = UILabel()
    private let cardTypeImageView = UIImageView()
    private let cardNumberLabel = UILabel()

    // MARK: - initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCardTypeImageView(cardType: ChooseNewCardModel.BaseCardViewModel) {
        cardTitleLabel.text = cardType.name
        switch cardType.type {
        case .debit:
            cardTypeImageView.image = UIImage(resource: .debitTypeIcon)
            backgroundImageView.image = UIImage(resource: .smartSilver)
        case .credit:
            cardTypeImageView.image =  UIImage(resource: .creditTypeIcon)
            backgroundImageView.image = UIImage(resource: .smartSilverCredit)
        }
    }

    // MARK: - UI setup
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
    }
    
    private func addViews() {
        addSubview(backgroundImageView)
        addSubview(cardTitleLabel)
        addSubview(cardNumberLabel)
        addSubview(cardTypeImageView)
    }
    
    private func setupViews() {
        self.layer.cornerRadius = Size.smallM
        self.clipsToBounds = true
        
        cardTitleLabel.font = Font.mediumMiddleM
        cardTitleLabel.textColor = .white

        cardNumberLabel.text = Constants.numberHiddenPart
        cardNumberLabel.textColor = .white
        cardNumberLabel.font = Font.monospacedRegularSmallXL
    }
    
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        cardTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(Size.smallXL)
        }
        cardTypeImageView.snp.makeConstraints { make in
            make.centerY.equalTo(cardTitleLabel.snp.centerY)
            make.leading.equalTo(cardTitleLabel.snp.trailing).offset(Size.smallXL)
            make.height.equalTo(Constants.cardTypeImageHeight)
            make.width.equalTo(Constants.cardTypeImageWidth)
        }
        cardNumberLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(Size.smallXL)
        }

    }
}

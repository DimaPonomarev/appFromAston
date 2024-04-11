//
//  CardCell.swift
//  BettaBank
//
//  Created by Egor Kruglov on 27.11.2023.
//

import UIKit

class CardCell: UICollectionViewCell {

    // MARK: - external dependencies
    
    var viewModel: CardCellViewModelProtocol? {
        didSet {
            cardBalanceLabel.text = viewModel?.cardData.balance
            cardNameInsideViewLabel.text = viewModel?.cardData.name
            cardNumberLabel.text = viewModel?.cardData.number
            expirationLabel.text = viewModel?.cardData.expirationDate
            cardNameLabel.text = viewModel?.cardData.name
            cardImageView.image = getBackgroundImage()
        }
    }

    // MARK: - ui elements
    
    private let cardImageView = UIImageView()
    private let cardBalanceLabel = UILabel()
    private let cardNameInsideViewLabel = UILabel()
    private let cardNameLabel = UILabel()
    private let cardNumberLabel = UILabel()
    private let expirationLabel = UILabel()
    
    // MARK: - initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - setup ui
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
    }
    
    private func addViews() {
        [cardImageView,
         cardBalanceLabel,
         cardNameLabel,
         cardNumberLabel,
         expirationLabel].forEach { addSubview($0) }
        cardImageView.addSubview(cardNameInsideViewLabel)
    }
    
    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = Size.smallXL
        cardImageView.contentMode = .scaleAspectFill
        cardImageView.layer.cornerRadius = Size.smallM
        cardImageView.clipsToBounds = true
        cardImageView.backgroundColor = .black
        
        cardBalanceLabel.font = Font.boldSmallXL
        
        cardNameLabel.font = Font.regularSmallXL
        cardNameLabel.textColor = .textColor
        
        cardNameInsideViewLabel.font = Font.regularSmallL
        cardNameInsideViewLabel.textColor = UIColor.white
       
        expirationLabel.textColor = .textColor
        expirationLabel.font = Font.regularSmallL
    }
    
    private func setupConstraints() {
        cardImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(Size.smallXL)
            make.width.equalTo(MainPageSizes.cardWidth)
        }
        
        cardBalanceLabel.snp.makeConstraints { make in
            make.leading.equalTo(cardImageView.snp.trailing).offset(Size.smallXL)
            make.top.equalToSuperview().inset(Size.smallXL)
        }
        
        cardNameInsideViewLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(Size.smallL)
        }
        
        cardNameLabel.snp.makeConstraints { make in
            make.top.equalTo(cardBalanceLabel.snp.bottom).offset(Size.smallS)
            make.leading.equalTo(cardBalanceLabel.snp.leading)
        }
        
        cardNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(cardImageView.snp.trailing).offset(Size.smallXL)
            make.bottom.equalToSuperview().inset(Size.smallL)
        }
        
        expirationLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(Size.smallXL)
        }
    }
    
    private func getBackgroundImage() -> UIImage {
        switch viewModel?.cardData.cardOption {
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
        case .none:
            return UIImage()
        }
    }
}

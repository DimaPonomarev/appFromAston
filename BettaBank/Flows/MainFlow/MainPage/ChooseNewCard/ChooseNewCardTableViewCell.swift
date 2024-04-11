//
//  ChooseNewCardTableViewCell.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 24.01.2024.
//

import UIKit

private enum Constants {
    static let monthlyCostTitle = "Ежемесячная стоимость обслуживания карты"
    static let currencylTitle = "Валюта"
    static let cardLeveltitle = "Уровень карты"
    static let cardTypeTitle = "Тип карты"
}

class ChooseNewCardTableViewCell: UITableViewCell {
    
    //  MARK: - UI properties
    
    private let somecardView = CustomCardView()
    
    private let cardDescriptionStackView = UIStackView()
    private let cardValuesStackView = UIStackView()
    private let cardSummaryTitleLabel = UILabel()
    private let monthlyCostTitleLabel = UILabel()
    private let monthlyCostValueLabel = UILabel()
    private let currencylTitleLabel = UILabel()
    private let currencylValueLabel = UILabel()
    private let cardLevelTitleLabel = UILabel()
    private let cardLevelValueLabel = UILabel()
    private let cardTypeTitleLabel = UILabel()
    private let cardTypeValuelabel = UILabel()
    
    private let showMoreButton =  UILabel()
    
    //  MARK: init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupShowMoreLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.setGradientBackground(from: .gradientBackgroundColor, to: .clear)
    }
    
    // MARK: - Public Methods
    
    func configureView(_ model: ChooseNewCardModel) {
        somecardView.setupCardTypeImageView(cardType: ChooseNewCardModel.BaseCardViewModel(type: model.productType, name: model.productName))
        cardSummaryTitleLabel.text = model.productName
        monthlyCostValueLabel.text = "\(model.purchaseFee)"
        currencylValueLabel.text = model.currencyName
        cardLevelValueLabel.text = model.loyaltyProgram
        cardTypeValuelabel.text = model.productType.rawValue
    }
}

//  MARK: - Private methods

private extension ChooseNewCardTableViewCell {
    
    //  MARK: - Setup
    
    func setup() {
        addViews()
        makeConstraints()
        setupViews()
    }
    
    //  MARK: - addViews
    
    func addViews() {
        contentView.addSubview(cardSummaryTitleLabel)
        contentView.addSubview(somecardView)
        
        contentView.addSubview(cardDescriptionStackView)
        cardDescriptionStackView.addArrangedSubview(monthlyCostTitleLabel)
        cardDescriptionStackView.addArrangedSubview(currencylTitleLabel)
        cardDescriptionStackView.addArrangedSubview(cardLevelTitleLabel)
        cardDescriptionStackView.addArrangedSubview(cardTypeTitleLabel)
        
        contentView.addSubview(cardValuesStackView)
        cardValuesStackView.addArrangedSubview(monthlyCostValueLabel)
        cardValuesStackView.addArrangedSubview(currencylValueLabel)
        cardValuesStackView.addArrangedSubview(cardLevelValueLabel)
        cardValuesStackView.addArrangedSubview(cardTypeValuelabel)
        contentView.addSubview(showMoreButton)
    }
    
    //  MARK: - makeConstraints
    
    func makeConstraints() {
        cardSummaryTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Size.middleM)
            make.width.equalToSuperview()
        }
        somecardView.snp.makeConstraints { make in
            make.top.equalTo(cardSummaryTitleLabel.snp.bottom).offset(Size.middleM)
            make.horizontalEdges.equalToSuperview().inset(Size.middleS)
            make.height.equalTo(CardView.cardViewHeight)
        }
        
        cardDescriptionStackView.snp.makeConstraints { make in
            make.top.equalTo(somecardView.snp.bottom).offset(Size.middleM)
            make.left.equalToSuperview()
            make.right.equalTo(cardValuesStackView.snp.left)
        }
        cardValuesStackView.snp.makeConstraints { make in
            make.top.equalTo(cardDescriptionStackView)
            make.left.equalTo(cardDescriptionStackView.snp.right)
            make.right.equalToSuperview()
            make.bottom.equalTo(cardDescriptionStackView.snp.bottom)
        }
        showMoreButton.snp.makeConstraints { make in
            make.top.equalTo(cardDescriptionStackView.snp.bottom).offset(Size.middleM)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().inset(Size.middleM)
        }
    }
    
    //  MARK: - setupViews
    
    func setupViews() {
        cardDescriptionStackView.axis = .vertical
        cardDescriptionStackView.spacing = Size.smallXL
        cardValuesStackView.axis = .vertical
        cardValuesStackView.alignment = .trailing
        cardValuesStackView.spacing = Size.smallXL
        cardDescriptionStackView.arrangedSubviews
            .compactMap { $0 as? UILabel }
            .forEach { $0.font = Font.regularSmallXL}
        cardValuesStackView.arrangedSubviews
            .compactMap { $0 as? UILabel }
            .forEach { $0.font = Font.mediumSmallXL}
        
        monthlyCostTitleLabel.numberOfLines = 0
        monthlyCostTitleLabel.text = Constants.monthlyCostTitle
        currencylTitleLabel.text = Constants.currencylTitle
        cardLevelTitleLabel.text = Constants.cardLeveltitle
        cardTypeTitleLabel.text = Constants.cardTypeTitle
    }
    
    private func setupShowMoreLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: Font.regularSmallXL,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.systemBlue
        ]
        
        let text = NSMutableAttributedString(
            string: String.Demo.showMoreButtonTitle.localized(),
            attributes: attributes
        )
        showMoreButton.attributedText = text
    }
}

//
//  CurrenciesView.swift
//  BettaBank
//
//  Created by Egor Kruglov on 27.11.2023.
//

import UIKit

final class CurrenciesView: UIView {

    // MARK: - external dependencies
    
    let currencies = Currency.demoCurrencies

    // MARK: - ui elements
    
    private let currencyTitleLabel = UILabel()
    private let purchaseCostTitleLabel = UILabel()
    private let sellCostTitleLabel = UILabel()
    private lazy var titlesLabels = [
        currencyTitleLabel,
        purchaseCostTitleLabel,
        sellCostTitleLabel
    ]
    private let titlesStack = UIStackView()
    private let valuesStack = UIStackView()

    // MARK: - initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ui setup
    
    private func setup() {
        addViews()
        setupView()
        setupConstraints()
    }
    
    private func addViews() {
        addSubview(titlesStack)
        addSubview(valuesStack)
    }
    
    private func setupView() {
        backgroundColor = UIColor.itemBackgroundColor
        layer.cornerRadius = Size.smallXL
        
        titlesStack.axis = .horizontal
        titlesStack.distribution = .fillEqually
        titlesStack.alignment = .fill
        titlesStack.spacing = Size.middleM
        titlesLabels.forEach { label in
            label.textAlignment = .center
            titlesStack.addArrangedSubview(label)
        }
        
        valuesStack.axis = .vertical
        valuesStack.distribution = .fillEqually
        valuesStack.spacing = Size.smallXL
        currencies.forEach { currency in
            let view = CurrencyLineView(currency: currency)
            valuesStack.addArrangedSubview(view)
        }
        
        currencyTitleLabel.text = MainPageTextLabels.currencyTitleLabel
        purchaseCostTitleLabel.text = MainPageTextLabels.purchaseCostTitleLabel
        sellCostTitleLabel.text = MainPageTextLabels.sellCostTitleLabel     
    }
    
    private func setupConstraints() {
        titlesStack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Size.middleXL)
            make.top.equalToSuperview().inset(Size.smallXL)
        }
    
        valuesStack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Size.middleXL)
            make.top.equalTo(titlesStack.snp.bottom).offset(Size.middleM)
            make.bottom.equalToSuperview().inset(Size.smallXL)
        }
    }    
}

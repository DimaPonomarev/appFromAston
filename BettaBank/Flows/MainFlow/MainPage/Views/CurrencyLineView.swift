//
//  CurrencyLineView.swift
//  BettaBank
//
//  Created by Egor Kruglov on 28.11.2023.
//

import UIKit

final class CurrencyLineView: UIView {

    // MARK: - external dependencies
    
    private let currency: Currency

    // MARK: - ui elements
    
    private let flagImageView = UIImageView()
    private let nameLabel = UILabel()
    private let stackForFlagAndName = UIStackView()
    private let buyCostLabel = UILabel()
    private let sellCostLabel = UILabel()
    private let stackForAllElements = UIStackView()

    // MARK: - initializers
    
    init(currency: Currency) {
        self.currency = currency
        super.init(frame: .zero)
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
        stackForFlagAndName.addArrangedSubview(flagImageView)
        stackForFlagAndName.addArrangedSubview(nameLabel)
        
        [stackForFlagAndName, buyCostLabel, sellCostLabel].forEach { view in
            stackForAllElements.addArrangedSubview(view)
        }
        
        addSubview(stackForAllElements)
    }
    
    private func setupViews() {
        flagImageView.image = UIImage(named: currency.roundedFlagImageName)
        flagImageView.contentMode = .scaleAspectFit
        
        [nameLabel, buyCostLabel, sellCostLabel].forEach {
            $0.font = Font.regularSmallXL
            $0.textAlignment = .center
        }
        
        nameLabel.text = currency.name.uppercased()
        buyCostLabel.text = String(currency.buyCost)
        sellCostLabel.text = String(currency.sellCost)
        
        stackForFlagAndName.axis = .horizontal
        stackForFlagAndName.distribution = .fill
        stackForFlagAndName.spacing = Size.smallM
        
        stackForAllElements.axis = .horizontal
        stackForAllElements.distribution = .fillEqually
        stackForAllElements.spacing = Size.middleXL
    }
    
    private func setupConstraints() {
        flagImageView.snp.makeConstraints { make in
            make.size.equalTo(Size.middleM)
        }
        
        stackForAllElements.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

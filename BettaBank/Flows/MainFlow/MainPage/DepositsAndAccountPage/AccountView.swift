//
//  AccountView.swift
//  BettaBank
//
//  Created by Dzhami on 19.12.2023.
//

import UIKit

private enum Constants {
    static let logoImageWidth = 70
}

final class AccountView: UIView {
    
    private let logoImage = UIImageView()
    private let mainTitle = UILabel()
    private let productPercent = UILabel()
    
    private let currency = UILabel()
    private let currencyValue = UILabel()
    
    private let leftStackView = UIStackView()
    private let rightStackView = UIStackView()
    
    private let opening = UILabel()
    private let openingValue = UILabel()
    
    private let percent = UILabel()
    private let percentValue = UILabel()
    
    private let withdrawal = UILabel()
    private let withdrawalValue = UILabel()
    
    private let minSum = UILabel()
    private let minSumValue = UILabel()
    
    private let maxSum = UILabel()
    private let maxSumValue = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        makeConsrtaints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        [logoImage, mainTitle, productPercent, leftStackView, rightStackView].forEach { addSubview($0) }
        
        [currency, opening, percent, withdrawal, minSum, maxSum].forEach { leftStackView.addArrangedSubview($0) }
        
        [currencyValue, openingValue, percentValue, withdrawalValue, minSumValue, maxSumValue].forEach {  rightStackView.addArrangedSubview($0) }
    }
    
    private func makeConsrtaints() {
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(Size.middleS)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constants.logoImageWidth)
            make.height.equalTo(logoImage.snp.width)
        }
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(Size.smallXL)
            make.centerX.equalToSuperview()
        }
        productPercent.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(Size.smallS)
            make.centerX.equalToSuperview()
        }
        leftStackView.snp.makeConstraints { make in
            make.top.equalTo(productPercent.snp.bottom).offset(Size.largeM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        
        rightStackView.snp.makeConstraints { make in
            make.top.equalTo(productPercent.snp.bottom).offset(Size.largeM)
            make.trailing.equalToSuperview().offset(-Size.smallXL)
        }
        
        [leftStackView, rightStackView].forEach { stackView in
            stackView.axis = .vertical
            stackView.distribution = .fillProportionally
            stackView.spacing = Size.smallM
        }
    }
    
    private func setupViews() {
        rightStackView.alignment = .trailing
        
        mainTitle.font = Font.regularMiddleXL
        mainTitle.textColor = .textColor
        productPercent.font = Font.regularSmallXL
        productPercent.textColor = .accountAndDepositPercent
        logoImage.image = UIImage(resource: .customerLoanIcon)
        
        currency.text = DepositStringValue.currency
        opening.text = DepositStringValue.opening
        percent.text = DepositStringValue.percent
        withdrawal.text = DepositStringValue.refillAndWithdrawal
        minSum.text = DepositStringValue.minSum
        maxSum.text = DepositStringValue.maxSum
        
        let labels = [currency, 
                      currencyValue,
                      opening,
                      openingValue,
                      percent,
                      percentValue,
                      withdrawal,
                      withdrawalValue,
                      minSum,
                      minSumValue,
                      maxSum,
                      maxSumValue]
        
        for label in labels {
            label.font = Font.regularSmallL
        }
    }
    
    func configureDepositScreen(model: AccountFullInfoModel) {
        mainTitle.text = model.productName
        productPercent.text = model.productPercent
        currencyValue.text = model.currency
        openingValue.text = model.opening
        percentValue.text = model.percent
        withdrawalValue.text = model.withdrawal
        minSumValue.text = model.minSum
        maxSumValue.text = model.maxSum
    }
}

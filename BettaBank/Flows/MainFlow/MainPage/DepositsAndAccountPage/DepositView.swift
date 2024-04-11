//
//  DepositView.swift
//  BettaBank
//
//  Created by Dzhami on 20.12.2023.
//

import UIKit

private enum Constants {
    static let logoImageWidth = 70
}

final class DepositView: UIView {
    
    private let logoImage = UIImageView()
    private let mainTitle = UILabel()
    private let productPercent = UILabel()
    
    private let leftStackView = UIStackView()
    private let rightStackView = UIStackView()
    
    private let duration = UILabel()
    private let durationValue = UILabel()
    
    private let sum = UILabel()
    private let sumValue = UILabel()
    
    private let percent = UILabel()
    private let percentValue = UILabel()
    
    private let refill = UILabel()
    private let refillValue = UILabel()
    
    private let withdrawal = UILabel()
    private let withdrawalValue = UILabel()
    
    private let capitalization = UILabel()
    private let capitalizationValue = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setup()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        [logoImage, mainTitle, productPercent, leftStackView, rightStackView].forEach { addSubview($0) }
        
        [duration, sum, percent, refill, withdrawal, capitalization].forEach { leftStackView.addArrangedSubview($0) }
        
        [ durationValue, sumValue, percentValue, refillValue, withdrawalValue, capitalizationValue].forEach {  rightStackView.addArrangedSubview($0) }
    }
    
    private func setup() {
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
        
        duration.text = DepositStringValue.duration
        sum.text = DepositStringValue.sum
        percent.text = DepositStringValue.percent
        refill.text = DepositStringValue.refill
        withdrawal.text = DepositStringValue.withdrawal
        capitalization.text = DepositStringValue.capitalization
        
        let labels = [duration, durationValue, sum, sumValue, percent, percentValue, refill, refillValue, withdrawal, withdrawalValue, capitalization, capitalizationValue]
        
        for label in labels {
            label.font = Font.regularSmallL
        }
    }
    
    func configureDepositScreen(model: DepositFullInfoModel) {
        mainTitle.text = model.productName
        productPercent.text = model.productPercent
        durationValue.text = model.duration
        sumValue.text = model.sum
        percentValue.text = model.percent
        refillValue.text = model.refill
        withdrawalValue.text = model.withdrawal
        capitalizationValue.text = model.capitalization
    }
}

//
//  LoanView.swift
//  BettaBank
//
//  Created by Dzhami on 08.01.2024.
//

import UIKit

private enum Constants {
    static let logoImageWidth = 70
}

class LoanView: UIView {
    private let logoImage = UIImageView()
    private let mainTitle = UILabel()
    private let loanType = UILabel()
    private let productPercent = UILabel()
    private let loanDescription = UILabel()
    
    private let leftStackView = UIStackView()
    private let rightStackView = UIStackView()
    
    private let minSum = UILabel()
    private let minSumValue = UILabel()
    
    private let maxSum = UILabel()
    private let maxSumValue = UILabel()
    
    private let duration = UILabel()
    private let durationValue = UILabel()
    
    private let earlyRepayment = UILabel()
    private let earlyRepaymentValue = UILabel()
    
    private let guarantors = UILabel()
    private let guarantorsValue = UILabel()
    
    private let incomeSertificate = UILabel()
    private let incomeSertificateValue = UILabel()
    
    private let withdrawal = UILabel()
    private let withdrawalValue = UILabel()
    
    private let deposit = UILabel()
    private let depositValue = UILabel()
    
    private let calculationScheme = UILabel()
    private let calculationSchemeValue = UILabel()
    
    private let lateFee = UILabel()
    private let lateFeeValue = UILabel()
    
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
        [logoImage, mainTitle, loanType, productPercent, loanDescription, leftStackView, rightStackView].forEach { addSubview($0) }
        
        [minSum, maxSum, duration, earlyRepayment, guarantors, incomeSertificate, withdrawal, deposit, calculationScheme, lateFee].forEach { leftStackView.addArrangedSubview($0) }
        
        [minSumValue, maxSumValue, durationValue, earlyRepaymentValue, guarantorsValue, incomeSertificateValue, withdrawalValue, depositValue, calculationSchemeValue, lateFeeValue].forEach { rightStackView.addArrangedSubview($0) }
        
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
        loanType.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(Size.smallS)
            make.centerX.equalToSuperview()
        }
        productPercent.snp.makeConstraints { make in
            make.top.equalTo(loanType.snp.bottom).offset(Size.smallS)
            make.centerX.equalToSuperview()
        }

        loanDescription.snp.makeConstraints { make in
            make.top.equalTo(productPercent.snp.bottom).offset(Size.middleL)
            make.centerX.equalToSuperview()
        }
        
        leftStackView.snp.makeConstraints { make in
            make.top.equalTo(loanDescription.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        
        rightStackView.snp.makeConstraints { make in
            make.top.equalTo(loanDescription.snp.bottom).offset(Size.smallM)
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
        loanType.font = Font.boldSmallL
        productPercent.font = Font.regularSmallXL
        productPercent.textColor = .accountAndDepositPercent
        logoImage.image = UIImage(resource: .rubleIconLoan)
        
        minSum.text = LoanStringValue.minimalCountTitle
        maxSum.text = LoanStringValue.maximalCountTitle
        duration.text = LoanStringValue.minimalTermTitle
        earlyRepayment.text = LoanStringValue.earlyRepaymentTitle
        guarantors.text = LoanStringValue.guarantorsTitle
        incomeSertificate.text = LoanStringValue.certificationTitle
        withdrawal.text = LoanStringValue.withdrawal
        deposit.text = LoanStringValue.deposit
        calculationScheme.text = LoanStringValue.calculationScheme
        lateFee.text = LoanStringValue.lateFee
        
        let labels = [loanDescription, minSum, minSumValue, maxSum, maxSumValue, duration, durationValue, earlyRepayment, earlyRepaymentValue, guarantors, guarantorsValue, incomeSertificate, incomeSertificateValue, withdrawal, withdrawalValue, deposit, depositValue, calculationScheme, calculationSchemeValue, lateFee, lateFeeValue]

        for label in labels {
            label.font = Font.regularSmallL
        }
    }
    
    func configureDepositScreen(model: LoanFullInfoModel) {
        mainTitle.text = model.productName
        loanType.text = model.loanType
        productPercent.text = model.productPercent
        loanDescription.text = model.loanDescription
        
        minSumValue.text = model.minSum
        maxSumValue.text = model.maxSum
        durationValue.text = model.duration
        earlyRepaymentValue.text = model.earlyRepayment
        guarantorsValue.text = model.guarantors
        incomeSertificateValue.text = model.incomeSertificate
        withdrawalValue.text = model.withdrawal
        depositValue.text = model.deposit
        calculationSchemeValue.text = model.calculationScheme
        lateFeeValue.text = model.lateFee
    }
}

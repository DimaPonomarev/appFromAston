//
//  CustomerLoansViewController.swift
//  BettaBank
//
//  Created by Sofia Norina on 11.01.2024.
//
//  Пример вызова
//  FullPersonalLoanModel(creditSum: 1700,
//                      creditTerm: 12,
//                      principalDebt: 123456,
//                      interestDebt: 1233456,
//                      periodPayment: 12345,
//                      creditDate: "2023-11-27T11:55:20Z",
//                      creditCloseDate: "2023-11-27T11:55:20Z",
//                      creditNextPayment: "2023-11-27T11:55:20Z",
//                      penalty: 123)

import UIKit
import SnapKit

private enum Constants {
    static let acceptLabelClosed = "Закрыт"
    static let acceptLabelActive = "Активен"
    static let acceptLabelBlocked = "Заблокирован"
    static let openNameTitle = "Открыт"
    static let creditSum = "Первоначальная сумма"
    static let creditTerm = "Срок кредитования"
    static let principalDebt = "Основной долг"
    static let interestDebt = "Проценты"
    static let periodPayment = "Сумма ежемесячного платежа"
    static let creditDate = "Дата открытия"
    static let creditCloseDate = "Дата окончания"
    static let creditNextPayment = "Ближайший платеж"
    static let penalty = "Пеня за просрочку"
    static let mounthTitle = "месяцев"
    
    static let blockedButtonColor = UIColor(red: 0.96, green: 0.236, blue: 0.077, alpha: 1)
    
    static let buttonWidth = 156
    static let topOffset = 88
}

final class CustomerLoansViewController: UIViewController {
    
    //  MARK: - private properties
    
    private let dateFormat = CustomDateFormatter()
    private let numberFormat = CustomNumberFormatter()
    
    //  MARK: - UI properties
    
    private let logoImage = UIImageView()
    private let loanName = UILabel()
    private let loanDescription = UILabel()
    private let percentLabel = UILabel()
    private let statusLabel = UILabel()
    
    private let creditSum = UILabel()
    private let creditSumValue = UILabel()
    
    private let creditTerm = UILabel()
    private let creditTermValue = UILabel()
    
    private let principalDebt = UILabel()
    private let principalDebtValue = UILabel()
    
    private let interestDebt = UILabel()
    private let interestDebtValue = UILabel()
    
    private let periodPayment = UILabel()
    private let periodPaymentValue = UILabel()
    
    private let creditDate = UILabel()
    private let creditDateValue = UILabel()
    
    private let creditCloseDate = UILabel()
    private let creditCloseDateValue = UILabel()
    
    private let creditNextPayment = UILabel()
    private let creditNextPaymentValue = UILabel()
    
    private let penalty = UILabel()
    private let penaltyValue = UILabel()
    
    //  MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func configureMainInfo(model: PersonalLoanModel) {
        loanName.text = model.productName
        percentLabel.text = model.percent
        
        switch model.statusType {
        case .active:
            statusLabel.backgroundColor = .greenLabelColor
            statusLabel.text = Constants.acceptLabelActive
        case .blocked:
            statusLabel.backgroundColor = Constants.blockedButtonColor
            statusLabel.text = Constants.acceptLabelBlocked
        case .closed:
            statusLabel.backgroundColor = .notActiveButtonColor
            statusLabel.text = Constants.acceptLabelClosed
        }
    }
    
    func configureFullInfo(model: FullPersonalLoanModel) {
        numberFormat.configureFormatter(number: model.creditSum, label: creditSumValue)
        creditTermValue.text = "\(model.creditTerm) \(Constants.mounthTitle)"
        numberFormat.configureFormatter(number: model.principalDebt, label: principalDebtValue)
        numberFormat.configureFormatter(number: model.interestDebt, label: interestDebtValue)
        numberFormat.configureFormatter(number: model.periodPayment, label: periodPaymentValue)
        creditDateValue.text = dateFormat.convertDateStringToTime(
            originalDateString: model.creditDate,
            originalFormat: CustomDateForrmater.original.rawValue,
            targetFormat: CustomDateForrmater.onlyDate.rawValue)
        creditCloseDateValue.text = dateFormat.convertDateStringToTime(
            originalDateString: model.creditCloseDate,
            originalFormat: CustomDateForrmater.original.rawValue,
            targetFormat: CustomDateForrmater.onlyDate.rawValue)
        print(creditCloseDateValue)
        creditNextPaymentValue.text = dateFormat.convertDateStringToTime(
            originalDateString: model.creditNextPayment,
            originalFormat: CustomDateForrmater.original.rawValue,
            targetFormat: CustomDateForrmater.onlyDate.rawValue)
        
        penaltyValue.text = "\(model.penalty)%"
    }
    
    private func setup() {
        addViews()
        setupMainInfoViews()
        setupFullInfoViews()
        setupMainInfoConstraints()
        setupLeftColumnConstraints()
        setupRightColumnConstraints()
        setupBackNavigationButton(type: .pop)
    }
    
    private func addViews() {
        [logoImage,
         loanName,
         loanDescription,
         percentLabel,
         statusLabel,
         creditSum,
         creditSumValue,
         creditTerm,
         creditTermValue,
         creditDate,
         creditDateValue,
         principalDebt,
         principalDebtValue,
         interestDebt,
         interestDebtValue,
         periodPayment,
         periodPaymentValue,
         creditCloseDate,
         creditCloseDateValue,
         creditNextPayment,
         creditNextPaymentValue,
         penalty,
         penaltyValue
        ].forEach { view.addSubview($0) }
    }
    
    private func setupMainInfoConstraints() {
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.topOffset)
            make.centerX.equalToSuperview()
            make.width.equalTo(Size.middleXL)
            make.height.equalTo(logoImage.snp.width)
        }
        loanName.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(Size.smallXL)
            make.centerX.equalToSuperview()
        }
        percentLabel.snp.makeConstraints { make in
            make.top.equalTo(loanName.snp.bottom).offset(Size.smallM)
            make.centerX.equalToSuperview()
        }
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(percentLabel.snp.bottom).offset(Size.smallXL)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constants.buttonWidth)
            make.height.equalTo(Size.largeS)
        }
    }
    
    private func setupLeftColumnConstraints() {
        creditSum.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(Size.largeXL)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        creditTerm.snp.makeConstraints { make in
            make.top.equalTo(creditSum.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        principalDebt.snp.makeConstraints { make in
            make.top.equalTo(creditTerm.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        interestDebt.snp.makeConstraints { make in
            make.top.equalTo(principalDebt.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        periodPayment.snp.makeConstraints { make in
            make.top.equalTo(interestDebt.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        creditDate.snp.makeConstraints { make in
            make.top.equalTo(periodPayment.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        creditCloseDate.snp.makeConstraints { make in
            make.top.equalTo(creditDate.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        creditNextPayment.snp.makeConstraints { make in
            make.top.equalTo(creditCloseDate.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        penalty.snp.makeConstraints { make in
            make.top.equalTo(creditNextPayment.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
    }
    
    private func setupRightColumnConstraints() {
        creditSumValue.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(Size.largeXL)
            make.trailing.equalToSuperview().inset(Size.smallXL)
        }
        creditTermValue.snp.makeConstraints { make in
            make.top.equalTo(creditSum.snp.bottom).offset(Size.smallM)
            make.trailing.equalToSuperview().inset(Size.smallXL)
        }
        principalDebtValue.snp.makeConstraints { make in
            make.top.equalTo(creditTerm.snp.bottom).offset(Size.smallM)
            make.trailing.equalToSuperview().inset(Size.smallXL)
        }
        interestDebtValue.snp.makeConstraints { make in
            make.top.equalTo(principalDebt.snp.bottom).offset(Size.smallM)
            make.trailing.equalToSuperview().inset(Size.smallXL)
        }
        periodPaymentValue.snp.makeConstraints { make in
            make.top.equalTo(interestDebt.snp.bottom).offset(Size.smallM)
            make.trailing.equalToSuperview().inset(Size.smallXL)
        }
        creditDateValue.snp.makeConstraints { make in
            make.top.equalTo(periodPayment.snp.bottom).offset(Size.smallM)
            make.trailing.equalToSuperview().inset(Size.smallXL)
        }
        creditCloseDateValue.snp.makeConstraints { make in
            make.top.equalTo(creditDate.snp.bottom).offset(Size.smallM)
            make.trailing.equalToSuperview().inset(Size.smallXL)
        }
        creditNextPaymentValue.snp.makeConstraints { make in
            make.top.equalTo(creditCloseDate.snp.bottom).offset(Size.smallM)
            make.trailing.equalToSuperview().inset(Size.smallXL)
        }
        penaltyValue.snp.makeConstraints { make in
            make.top.equalTo(creditNextPayment.snp.bottom).offset(Size.smallM)
            make.trailing.equalToSuperview().inset(Size.smallXL)
        }
    }
    
    private func setupMainInfoViews() {
        view.backgroundColor = .mainBackgroundColor
        
        loanName.font = Font.regularMiddleM
        loanName.textColor = .textColor
        percentLabel.font = Font.regularSmallXL
        percentLabel.textColor = .accountAndDepositPercent
        logoImage.image = UIImage(resource: .currencyRubIcon)
        
        statusLabel.layer.cornerRadius = Size.smallL
        statusLabel.clipsToBounds = true
        statusLabel.textAlignment = .center
        statusLabel.textColor = .white
        
    }
    
    private func setupFullInfoViews() {
        creditSum.text = Constants.creditSum
        creditSum.font = Font.regularSmallL
        creditTerm.text = Constants.creditTerm
        creditTerm.font = Font.regularSmallL
        principalDebt.text = Constants.principalDebt
        principalDebt.font = Font.regularSmallL
        interestDebt.text = Constants.interestDebt
        interestDebt.font = Font.regularSmallL
        periodPayment.text = Constants.periodPayment
        periodPayment.font = Font.regularSmallL
        creditDate.text = Constants.creditDate
        creditDate.font = Font.regularSmallL
        creditCloseDate.text = Constants.creditCloseDate
        creditCloseDate.font = Font.regularSmallL
        creditNextPayment.text = Constants.creditNextPayment
        creditNextPayment.font = Font.regularSmallL
        penalty.text = Constants.penalty
        penalty.font = Font.regularSmallL
        
        creditSumValue.font = Font.regularSmallL
        creditTermValue.font = Font.regularSmallL
        principalDebtValue.font = Font.regularSmallL
        interestDebtValue.font = Font.regularSmallL
        periodPaymentValue.font = Font.regularSmallL
        creditDateValue.font = Font.regularSmallL
        creditCloseDateValue.font = Font.regularSmallL
        creditNextPaymentValue.font = Font.regularSmallL
        penaltyValue.font = Font.regularSmallL
    }
}

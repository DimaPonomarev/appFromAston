//
//  OperationInfoViewController.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 12.12.2023.
//

import UIKit
import SnapKit

private enum Constants {
   static let visibleDigis = 4
}

final class OperationInfoViewController: UIViewController {
    
    private let dateFormat = CustomDateFormatter()
    private let operation: OperationModel
    
    //  MARK: - UI properties
    
    private let containerView = UIView()
    private let senderNameLabel = UILabel()
    private let senderAccountNameLabel = UILabel()
    private let senderAccountLabel = UILabel()
    private let operationCountNameLabel = UILabel()
    private let operationCountLabel = UILabel()
    private let userAccountNameLabel = UILabel()
    private let userAccountLabel = UILabel()
    private let bankNameLabel = UILabel()
    private let bankLabel = UILabel()
    private let dateNameLabel = UILabel()
    private let dateLabel = UILabel()
    private let operationTypeNameLabel = UILabel()
    private let operationTypeLabel = UILabel()
    
    // TODO: заполнить ответственному по задаче
    
    //  MARK: - init
    
    init(operation: OperationModel) {
        self.operation = operation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBackNavigationButton(type: .pop)
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
    }
    
    private func addViews() {
        view.addSubview(containerView)
        [senderNameLabel, 
         senderAccountNameLabel,
         senderAccountLabel,
         operationCountNameLabel,
         operationCountLabel,
         userAccountNameLabel,
         userAccountLabel,
         bankNameLabel,
         bankLabel,
         dateNameLabel,
         dateLabel,
         operationTypeNameLabel,
         operationTypeLabel].forEach {
            containerView.addSubview($0)
        }
    }
    
    private func setupViews() {
        title = HistoryStringValue.operationInfoTitle
        view.backgroundColor = .mainBackgroundColor
        containerView.layer.cornerRadius = Size.smallXL
        containerView.backgroundColor = .mainBackgroundColor
        containerView.layer.shadowColor = UIColor.shadowBackgroundColor.cgColor
        containerView.layer.shadowRadius = Size.smallM
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        senderNameLabel.text = operation.userName
        senderAccountLabel.text = applyCardMask(cardNumber: operation.fullInfo.senserAccountNumber)
        operationCountLabel.text = "\(operation.operationCount) P"
        userAccountLabel.text = applyCardMask(cardNumber: operation.fullInfo.userAccountNumber)
        bankLabel.text = operation.fullInfo.senderBank
        dateLabel.text = dateFormat.convertDateStringToTime(originalDateString: operation.operationTime,
                                                            originalFormat: CustomDateForrmater.original.rawValue,
                                                            targetFormat: CustomDateForrmater.fullDate.rawValue)
        operationTypeLabel.text = operation.operationType
        
        setupLabelText(label: senderAccountNameLabel, 
                       text: HistoryStringValue.senderAccountTitle,
                       font: Font.regularSmallL,
                       textColor: .notActiveTextColor)
        setupLabelText(label: operationCountNameLabel,
                       text: HistoryStringValue.operationCountTitle,
                       font: Font.regularSmallL,
                       textColor: .notActiveTextColor)
        setupLabelText(label: userAccountNameLabel,
                       text: HistoryStringValue.userAccauntTitle,
                       font: Font.regularSmallL,
                       textColor: .notActiveTextColor)
        setupLabelText(label: bankNameLabel,
                       text: HistoryStringValue.senderBankTitle,
                       font: Font.regularSmallL,
                       textColor: .notActiveTextColor)
        setupLabelText(label: dateNameLabel, 
                       text: HistoryStringValue.operationFullDate,
                       font: Font.regularSmallL,
                       textColor: .notActiveTextColor)
        setupLabelText(label: operationTypeNameLabel,
                       text: HistoryStringValue.operationTipeTitle,
                       font: Font.regularSmallL,
                       textColor: .notActiveTextColor)
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Size.middleS)
            make.horizontalEdges.equalToSuperview().inset(Size.smallXL)
        }
        senderNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Size.largeXL)
            make.centerX.equalToSuperview()
        }
        senderAccountNameLabel.snp.makeConstraints { make in
            make.top.equalTo(senderNameLabel.snp.bottom).offset(Size.smallXL)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        senderAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(senderAccountNameLabel.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        operationCountNameLabel.snp.makeConstraints { make in
            make.top.equalTo(senderAccountLabel.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        operationCountLabel.snp.makeConstraints { make in
            make.top.equalTo(operationCountNameLabel.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        userAccountNameLabel.snp.makeConstraints { make in
            make.top.equalTo(operationCountLabel.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        userAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(userAccountNameLabel.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        bankNameLabel.snp.makeConstraints { make in
            make.top.equalTo(userAccountLabel.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        bankLabel.snp.makeConstraints { make in
            make.top.equalTo(bankNameLabel.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        dateNameLabel.snp.makeConstraints { make in
            make.top.equalTo(bankLabel.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(dateNameLabel.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        operationTypeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        operationTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(operationTypeNameLabel.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
            make.bottom.equalToSuperview().inset(Size.largeXL)
        }
    }
    
    // MARK: - private func
    
    private func setupLabelText(label: UILabel, text: String, font: UIFont, textColor: UIColor) {
        label.text = text
        label.font = font
        label.textColor = textColor
    }
    
    private func applyCardMask(cardNumber: String) -> String {
        let visibleDigis = Constants.visibleDigis
        let maskedDigits = max(cardNumber.count - visibleDigis, 0)
        
        var maskedPart = ""
        for index in 0..<maskedDigits {
            if index > 0 && index % Constants.visibleDigis == 0 {
                maskedPart += " "
            }
            maskedPart += "*"
        }
        let visiblePart = String(cardNumber.suffix(visibleDigis))
        
        let maskedCardNumber = maskedPart + " " + visiblePart
        
        return maskedCardNumber
    }
}

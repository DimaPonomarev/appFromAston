//
//  AccountViewCell.swift
//  BettaBank
//
//  Created by Sofia Norina on 12.12.2023.
//

import UIKit
import SnapKit

private enum Constants {
    static let viewsWidth = 130
}

class AccountViewCell: UITableViewCell {
    
    //  MARK: - private properties
    
    private let numberForrmater = CustomNumberFormatter()
    
    //  MARK: - UI properties
    
    private let backgroundImageView = UIImageView()
    private let accountNameLabel = UILabel()
    private let typeOfAccountImageView = UIImageView()
    private let balanceLabel = UILabel()
    private let numberLabel = UILabel()
    private let statusAccountLabel = UILabel()
    private let typeOfAccountOnRightSideLabel = UILabel()
    
    //  MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - override func
    
    override func prepareForReuse() {
        super.prepareForReuse()
        accountNameLabel.text = nil
        balanceLabel.text = nil
        typeOfAccountOnRightSideLabel.text = nil
        numberLabel.text = nil
    }
    
    // MARK: - public func
    
    func configure(model: PersonalAccountModel) {
        
        numberForrmater.configureFormatter(number: model.balance, label: balanceLabel)
        
        statusAccountLabel.text = model.status.rawValue
        accountNameLabel.text = model.accountName
        typeOfAccountOnRightSideLabel.text = model.accountType
        numberLabel.text = model.accountNumber
        
        switch model.status {
        case .active:
            statusAccountLabel.backgroundColor = .greenLabelColor
        case .closed:
            statusAccountLabel.backgroundColor = .red
        }
    }
    
    //  MARK: - setup UI
    
    private func setupCell() {
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(accountNameLabel)
        backgroundImageView.addSubview(typeOfAccountImageView)
        backgroundImageView.addSubview(balanceLabel)
        backgroundImageView.addSubview(numberLabel)
        backgroundImageView.addSubview(statusAccountLabel)
        backgroundImageView.addSubview(typeOfAccountOnRightSideLabel)
    }
    
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Size.smallXL)
            make.verticalEdges.equalToSuperview().inset(Size.smallM)
        }
        accountNameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(Size.smallXL)
        }
        typeOfAccountImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(accountNameLabel)
            make.width.equalTo(Size.largeS)
            make.leading.equalTo(accountNameLabel.snp.trailing).offset(Size.smallM)
        }
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(accountNameLabel.snp.bottom).offset(Size.smallXL)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel.snp.bottom).offset(Size.middleS)
            make.leading.equalToSuperview().inset(Size.smallXL)
        }
        typeOfAccountOnRightSideLabel.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel).offset(Size.smallM)
            make.trailing.equalToSuperview().inset(Size.smallXL)
            make.width.equalTo(Constants.viewsWidth)
            make.height.equalTo(Size.largeS)
        }
        statusAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(Size.middleS)
            make.height.equalTo(Size.largeS)
            make.width.equalTo(Constants.viewsWidth)
            make.leading.equalToSuperview().inset(Size.smallXL)
            make.bottom.equalToSuperview().inset(Size.smallXL)
        }

    }
    
    private func setupViews() {
        backgroundImageView.image = UIImage(resource: .accountCard)
        backgroundImageView.layer.cornerRadius = Size.smallXL
        typeOfAccountImageView.image = UIImage(resource: .accountMark)
        typeOfAccountImageView.contentMode = .scaleAspectFit
        
        typeOfAccountOnRightSideLabel.font = Font.regularSmallL
        typeOfAccountOnRightSideLabel.textColor = .textColor
        typeOfAccountOnRightSideLabel.textAlignment = .center
        typeOfAccountOnRightSideLabel.backgroundColor = .systemGray4
        typeOfAccountOnRightSideLabel.layer.cornerRadius = Size.smallL
        typeOfAccountOnRightSideLabel.clipsToBounds = true
        typeOfAccountOnRightSideLabel.font = Font.boldSmallL
        
        numberLabel.font = Font.monospacedRegularSmallXL
        numberLabel.textColor = .white
        
        statusAccountLabel.textColor = .white
        statusAccountLabel.textAlignment = .center
        statusAccountLabel.backgroundColor = .red
        statusAccountLabel.layer.cornerRadius = Size.smallL
        statusAccountLabel.clipsToBounds = true
        
        accountNameLabel.textColor = .textColor
        accountNameLabel.font = Font.regularSmallXL
        accountNameLabel.textColor = .white
        
        balanceLabel.font = Font.mediumMiddleM
        balanceLabel.textColor = .white
    }
}

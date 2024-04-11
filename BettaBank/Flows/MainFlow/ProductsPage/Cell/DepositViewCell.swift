//
//  DepositViewCell.swift
//  BettaBank
//
//  Created by Sofia Norina on 12.12.2023.
//

import UIKit
import SnapKit

class DepositViewCell: UITableViewCell {
    
    //  MARK: - private properties
    
    private let numberForrmater = CustomNumberFormatter()
    
    //  MARK: - UI properties
    
    private let containerView = UIView()
    private let mainLabel = UILabel()
    private let iconView = UIImageView()
    private let countLabel = UILabel()
    private let numberLabel = UILabel()
    private let termLabel = UILabel()
    private let numberNameLabel = UILabel()
    private let termNameLabel = UILabel()
    
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
        mainLabel.text = nil
        countLabel.text = nil
        termLabel.text = nil
        numberLabel.text = nil
    }
    
    // MARK: - public func
    
    func configur(model: PersonalDepositModel) {
        numberForrmater.configureFormatter(number: model.productCount, label: countLabel)
        
        mainLabel.text = model.productName
        termLabel.text = model.productTerm
        numberLabel.text = model.productNumber
    }
    
    //  MARK: - setup UI
    
    private func setupCell() {
        addSubview(containerView)
        containerView.addSubview(mainLabel)
        containerView.addSubview(iconView)
        containerView.addSubview(countLabel)
        containerView.addSubview(numberLabel)
        containerView.addSubview(numberNameLabel)
        containerView.addSubview(termLabel)
        containerView.addSubview(termNameLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Size.smallXL)
            make.verticalEdges.equalToSuperview().inset(Size.smallM)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(Size.smallXL)
        }
        
        iconView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(Size.smallXL)
            make.leading.equalToSuperview().offset(Size.smallXL)
            make.height.equalTo(Size.largeM)
            make.width.equalTo(iconView.snp.height)
        }
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconView.snp.centerY)
            make.leading.equalTo(iconView.snp.trailing).offset(Size.smallXL)
        }
        
        numberNameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(Size.smallXL)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(numberNameLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(Size.smallXL)
        }
        
        termNameLabel.snp.makeConstraints { make in
            make.top.equalTo(numberNameLabel.snp.bottom).offset(Size.smallXL)
            make.leading.equalToSuperview().offset(Size.smallXL)
            make.bottom.equalToSuperview().inset(Size.smallXL)
        }
        
        termLabel.snp.makeConstraints { make in
            make.centerY.equalTo(termNameLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(Size.smallXL)
        }
    }
    
    private func setupViews() {
        
        containerView.backgroundColor = .itemBackgroundColor
        containerView.layer.cornerRadius = Size.smallXL
        selectionStyle = .none
        
        iconView.image = UIImage(resource: .productsIcon)
        
        termNameLabel.font = Font.regularSmallL
        termNameLabel.textColor = .notActiveTextColor
        
        numberNameLabel.font = Font.regularSmallL
        numberNameLabel.textColor = .notActiveTextColor
        
        termLabel.font = Font.regularSmallL
        termLabel.textColor = .textColor
        
        numberLabel.font = Font.regularSmallL
        numberLabel.textColor = .textColor
        
        mainLabel.textColor = .textColor
        mainLabel.font = Font.mediumSmallXL
        
        countLabel.font = Font.mediumMiddleM
    }
}

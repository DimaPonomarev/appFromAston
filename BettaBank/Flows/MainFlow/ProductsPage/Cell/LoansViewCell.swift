//
//  ProductViewCell.swift
//  BettaBank
//
//  Created by Софья Норина on 11.12.2023.
//

import UIKit
import SnapKit

private enum Constants {
    static let acceptLabelClosed = "Закрыт"
    static let acceptLabelActive = "Активен"
    static let acceptLabelBlocked = "Заблокирован"
    static let openNameTitle = "Открыт"
    
    static let labelWidth = 130
    
    static let blockedButtonColor = UIColor(red: 0.96, green: 0.236, blue: 0.077, alpha: 1)
}

class LoansViewCell: UITableViewCell {
    
    //  MARK: - private properties
    
    private let numberForrmater = CustomNumberFormatter()
    
    //  MARK: - UI properties
    
    private let containerView = UIView()
    private let mainLabel = UILabel()
    private let countLabel = UILabel()
    private let openLable = UILabel()
    private let openNameLabel = UILabel()
    private let iconView = UIImageView()
    private let leftStackView = UIStackView()
    private let rightStackView = UIStackView()
    private let acceptLabel = UILabel()
    
    //  MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupViews()
        setupConstraints()
        setupLeftSteckView()
        setupRightSteckView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - override func
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainLabel.text = nil
        countLabel.text = nil
        openLable.text = nil
        acceptLabel.text = nil
    }
    
    // MARK: - public func
    
    func configure(model: PersonalLoanModel) {
        numberForrmater.configureFormatter(number: model.countLabel, label: countLabel)
        openLable.text = model.openLabel
        mainLabel.text = model.productName
        
        switch model.statusType {
        case .active:
            acceptLabel.backgroundColor = .greenLabelColor
            acceptLabel.text = Constants.acceptLabelActive
        case .closed:
            acceptLabel.backgroundColor = .notActiveButtonColor
            acceptLabel.text = Constants.acceptLabelClosed
        case .blocked:
            acceptLabel.backgroundColor = Constants.blockedButtonColor
            acceptLabel.text = Constants.acceptLabelBlocked
        }
    }
    
    //  MARK: - setup UI
    
    private func setupCell() {
        addSubview(containerView)
        containerView.addSubview(rightStackView)
        containerView.addSubview(leftStackView)
        containerView.addSubview(mainLabel)
        containerView.addSubview(countLabel)
        containerView.addSubview(iconView)
        containerView.addSubview(acceptLabel)
        rightStackView.addSubview(openLable)
        leftStackView.addSubview(openNameLabel)
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Size.smallXL)
            make.verticalEdges.equalToSuperview().inset(Size.smallL)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Size.smallXL)
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        
        iconView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(Size.smallXL)
            make.width.equalTo(Size.largeM)
            make.height.equalTo(iconView.snp.width)
            make.leading.equalTo(mainLabel.snp.leading)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconView.snp.centerY)
            make.leading.equalTo(iconView.snp.trailing).offset(Size.smallXL)
        }
        
        acceptLabel.snp.makeConstraints { make in
            make.top.equalTo(openNameLabel.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
            make.height.equalTo(Size.middleXL)
            make.width.equalTo(Constants.labelWidth)
            make.bottom.equalToSuperview().inset(Size.smallXL)
        }
    }
    
    private func setupLeftSteckView() {
        leftStackView.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(Size.smallXL)
            make.leading.equalToSuperview()
            make.trailing.equalTo(self.snp.centerX)
        }
        
        openNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
            make.bottom.equalToSuperview().inset(Size.smallM)
        }
    }
    
    private func setupRightSteckView() {
        rightStackView.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(Size.smallXL)
            make.trailing.equalToSuperview()
            make.leading.equalTo(self.snp.centerX)
        }
        
        openLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Size.smallM)
            make.trailing.equalToSuperview().inset(Size.smallXL)
            make.bottom.equalToSuperview().inset(Size.smallM)
        }
    }
    
    private func setupViews() {
        
        selectionStyle = .none
        
        containerView.backgroundColor = .itemBackgroundColor
        containerView.layer.cornerRadius = Size.smallXL
        mainLabel.font = Font.mediumSmallXL
        mainLabel.textColor = .textColor
        
        iconView.image = UIImage(resource: .productsIcon)
        
        countLabel.font = Font.mediumMiddleM
        
        openNameLabel.text = Constants.openNameTitle
        openNameLabel.font = Font.regularSmallL
        openNameLabel.textColor = .notActiveTextColor
        openLable.font = Font.regularSmallL
        openLable.textColor = .textColor
        
        acceptLabel.backgroundColor = .greenLabelColor
        acceptLabel.layer.cornerRadius = Size.smallL
        acceptLabel.clipsToBounds = true
        acceptLabel.textAlignment = .center
        acceptLabel.textColor = .white
    }
}

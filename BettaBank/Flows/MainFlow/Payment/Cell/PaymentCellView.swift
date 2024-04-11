//
//  PaymentCellView.swift
//  BettaBank
//
//  Created by Софья Норина on 29.11.2023.
//

import UIKit
import SnapKit

class PaymentCellView: UITableViewCell {
    
    //  MARK: - UI properties
    
    private let containerView = UIView()
    private let paymentIcon = UIImageView()
    private let paymentLabel = UILabel()
    
    //  MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - override func
    
    override func prepareForReuse() {
        paymentLabel.text = nil
    }
    
    // MARK: - public func
    
    func configure(model: PaymentModel ) {
        
        paymentLabel.text = model.paymentTitle
    }
    
    //  MARK: - setup UI
    
    private func setupCell() {
        addSubview(containerView)
        containerView.addSubview(paymentIcon)
        containerView.addSubview(paymentLabel)
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Size.smallS)
            make.leading.trailing.equalToSuperview().inset(Size.smallXL)
        }
        
        paymentIcon.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(Size.smallXL)
            make.leading.equalToSuperview().offset(Size.middleS)
            make.width.equalTo(Size.middleS)
            make.height.equalTo(paymentIcon.snp.width)
        }
        
        paymentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(paymentIcon.snp.centerY)
            make.leading.equalTo(paymentIcon.snp.trailing).offset(Size.smallXL)
        }
    }
    
    private func setupViews() {
        paymentIcon.image = UIImage(resource: .paymentIcon)
        
        paymentLabel.font = Font.mediumSmallXL
        paymentLabel.textColor = UIColor.textColor
        
        containerView.layer.cornerRadius = Size.smallM
        containerView.backgroundColor = UIColor.itemBackgroundColor
    }
}

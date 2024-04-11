//
//  TemplateViewCell.swift
//  BettaBank
//
//  Created by Софья Норина on 5.12.2023.
//

import UIKit
import SnapKit

private enum Constants {
    static let multiplier: CGFloat = 0.7
    static let nextPageImageHeight: CGFloat = 14

}

final class TemplateViewCell: UITableViewCell {
    
    //  MARK: - UI properties
    
    private let containerView = UIView()
    private let mainLabel = UILabel()
    private let persentLabel = UILabel()
    private let mainImage = UIImageView()
    private let descriptionLabel = UILabel()
    private let nextPageImage = UIImageView()
    
    //  MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - internal func
    
    func configureDepositCell(model: DepositModel ) {
        mainLabel.text = model.productName
        persentLabel.text = model.productPercent
        descriptionLabel.text = model.productDescription
    }
    
    func configureAccountCell(model: AccountModel ) {
        mainLabel.text = model.productName
        persentLabel.text = model.productPercent
        descriptionLabel.text = model.productDescription
    }
    
    func configureLoanCell(model: LoanModel ) {
        mainLabel.text = model.productName
        persentLabel.text = model.productPercent
        descriptionLabel.text = model.productDescription
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainLabel.text = nil
        persentLabel.text = nil
        descriptionLabel.text = nil
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setupConstraints()
        setupViews()
    }
    
    private func addViews() {
        addSubview(containerView)
        [mainLabel, mainImage, persentLabel, descriptionLabel, nextPageImage].forEach {
            containerView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Size.smallXL)
            make.verticalEdges.equalToSuperview().inset(Size.smallM)
        }
        mainImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(Size.smallXL)
            make.width.equalTo(Size.middleXL)
            make.height.equalTo(mainImage.snp.width)
        }
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Size.smallXL)
            make.leading.equalTo(mainImage.snp.trailing).offset(Size.middleS)
        }
        persentLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(Size.smallM)
            make.leading.equalTo(mainImage.snp.leading)
        }
        nextPageImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(Size.smallXL)
            make.height.equalTo(Constants.nextPageImageHeight)
            make.width.equalTo(nextPageImage.snp.height).multipliedBy(Constants.multiplier)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(Size.smallXL)
            make.leading.equalTo(mainImage.snp.leading)
            make.top.equalTo(persentLabel.snp.bottom).offset(Size.smallM)
        }
    }
    
    private func setupViews() {
        containerView.backgroundColor = .mainBackgroundColor
        containerView.layer.cornerRadius = Size.smallXL
        selectionStyle = .none
        
        backgroundColor = .itemBackgroundColor
        
        mainImage.image = UIImage(resource: .dollarIcon)
        nextPageImage.image = UIImage(resource: .rightArrowIcon)
        
        mainLabel.font = Font.mediumSmallXL
        mainLabel.textColor = .textColor
        persentLabel.font = Font.regularSmallXL
        descriptionLabel.font = Font.regularSmallL
    }
}

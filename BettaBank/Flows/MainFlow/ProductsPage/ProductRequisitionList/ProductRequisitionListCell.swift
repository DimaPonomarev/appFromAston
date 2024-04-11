//
//  ProductRequisitionListCell.swift
//  BettaBank
//
//  Created by Vadim Blagodarny on 29.12.2023.
//

import Foundation
import UIKit

class ProductRequisitionStateLabel: UILabel {
    private let approvedColor = UIColor(red: 0.298, green: 0.686, blue: 0.314, alpha: 1)
    private let processingColor = UIColor(red: 0.996, green: 0.855, blue: 0, alpha: 1)
    private let deniedCancelledColor = UIColor(red: 0.96, green: 0.236, blue: 0.077, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = Font.regularSmallXL
        textColor = .white
        textAlignment = .center
        layer.cornerRadius = Size.smallL
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureState(state: ProductRequisitionState) {
        switch state {
        case .approved:
            backgroundColor = approvedColor
        case .processing:
            backgroundColor = processingColor
        case .denied:
            backgroundColor = deniedCancelledColor
        case .cancelled:
            backgroundColor = deniedCancelledColor
        }
    }
}

private enum Constants {
    static let detailsButtonFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    static let detailsButtonText = "Подробнее"
    static let statusLabelWidth = 120
    static let statusLabelHeight = 36
    static let detailsButtonWidth = 300
    static let detailsButtonHeight = 36
}

final class ProductRequisitionListCell: UITableViewCell {
    
    // MARK: - UI properties
    
    private let nameLabel = UILabel()
    private let statusLabel = ProductRequisitionStateLabel()
    private let detailsButton = UIButton()
    
    // MARK: - init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - override func
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        statusLabel.text = nil
        detailsButton.titleLabel?.text = nil
    }
    
    // MARK: - setup UI

    private func addViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(detailsButton)
    }
    
    private func setupViews() {
        nameLabel.font = Font.boldMiddleS
        detailsButton.setTitle(Constants.detailsButtonText, for: .normal)
        detailsButton.titleLabel?.font = Constants.detailsButtonFont
        detailsButton.setTitleColor(.black, for: .normal)
        detailsButton.layer.borderWidth = 1
        detailsButton.layer.borderColor = UIColor.yellowButtonColor.cgColor
        detailsButton.layer.cornerRadius = Size.smallM
    }
    
    private func setupConstraints() {
        statusLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Size.smallM)
            make.top.equalToSuperview().offset(Size.smallM)
            make.width.equalTo(Constants.statusLabelWidth)
            make.height.equalTo(Constants.statusLabelHeight)
        }

        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(statusLabel.snp.centerY)
            make.leading.equalToSuperview().offset(Size.smallM)
        }
        
        detailsButton.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(Size.smallM)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(Size.smallM)
            make.width.equalTo(Constants.detailsButtonWidth)
            make.height.equalTo(Constants.detailsButtonHeight)
        }
    }
    
    // MARK: - public func
    
    func configure(model: ProductRequisitionModel, actionClosure: @escaping () -> Void) {
        nameLabel.text = model.name
        statusLabel.text = model.state.rawValue
        statusLabel.configureState(state: model.state)
        detailsButton.addAction(UIAction(handler: { _ in
            actionClosure()
        }), for: .touchUpInside)
    }
}

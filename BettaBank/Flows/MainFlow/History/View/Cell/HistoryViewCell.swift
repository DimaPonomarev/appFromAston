//
//  StoryViewCell.swift
//  BettaBank
//
//  Created by Sofia Norina on 14.12.2023.
//

import UIKit
import SnapKit

class HistoryViewCell: UITableViewCell {
    
    //  MARK: - private properties
    
    private let dateFormatter = CustomDateFormatter()
    
    //  MARK: - UI properties
    
    private let senderNameLabel = UILabel()
    private let operationTypeLabel = UILabel()
    private let operationCount = UILabel()
    private let operationTimeLabel = UILabel()
    private let senderIcon = UIImageView()
    
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
        senderNameLabel.text = nil
        operationTypeLabel.text = nil
        operationCount.text = nil
        operationTimeLabel.text = nil
    }
    
    // MARK: - public func
    
    func configure(with model: OperationModel) {
        senderNameLabel.text = model.userName
        operationTimeLabel.text = dateFormatter.convertDateStringToTime(originalDateString: model.operationTime,
                                                                       originalFormat: CustomDateForrmater.original.rawValue,
                                                                       targetFormat: CustomDateForrmater.onlyTime.rawValue )
        operationTypeLabel.text = model.operationType
        if operationTypeLabel.text == HistoryStringValue.firstCellOperationType {
            operationCount.text = "+\(model.operationCount) P"
        } else {
            operationCount.text = "-\(model.operationCount) P"
        }
    }
    
    //  MARK: - setup UI
    
    private func setupCell() {
        addSubview(senderIcon)
        addSubview(senderNameLabel)
        addSubview(operationCount)
        addSubview(operationTimeLabel)
        addSubview(operationTypeLabel)
    }
    
    private func setupConstraints() {
        senderIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Size.smallM)
            make.leading.equalToSuperview().offset(Size.smallXL)
            make.width.equalTo(Size.largeM)
            make.height.equalTo(senderIcon.snp.width)
        }
        senderNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Size.smallM)
            make.leading.equalTo(senderIcon.snp.trailing).offset(Size.smallXL)
        }
        operationTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(senderNameLabel.snp.bottom).offset(Size.smallS)
            make.bottom.equalToSuperview().inset(Size.smallM)
            make.leading.leading.equalTo(senderNameLabel.snp.leading)
        }
        operationCount.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Size.smallXL)
            make.top.equalToSuperview().offset(Size.smallM)
        }
        operationTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(operationCount.snp.bottom).offset(Size.smallS)
            make.bottom.equalToSuperview().inset(Size.smallM)
            make.trailing.equalToSuperview().inset(Size.smallXL)
        }
    }
    
    private func setupViews() {
        
        operationCount.font = Font.regularSmallXL
        operationCount.textColor = .textColor
        
        senderNameLabel.font = Font.regularSmallXL
        senderNameLabel.textColor = .textColor
        
        operationTypeLabel.font = Font.regularSmallL
        operationTypeLabel.textColor = .notActiveTextColor
        
        operationTimeLabel.font = Font.regularSmallL
        operationTimeLabel.textColor = .notActiveTextColor
    }
}

//
//  NotificationsTableViewCell.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 06.12.2023.
//

import UIKit
import SnapKit

final class NotificationsTableViewCell: UITableViewCell {
    
    //  MARK: - UI properties
    
    private let titleView = UIView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    
    //  MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - public func
    
    func configure(model: NotificationModel) {
        titleLabel.text = model.title
        dateLabel.text = model.date
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
    }
    
    private func addViews() {
        [titleView, dateLabel].forEach {
            addSubview($0)
        }
        
        titleView.addSubview(titleLabel)
    }
    
    private func setupViews() {
        titleView.layer.cornerRadius = Size.smallXL
        titleView.backgroundColor = .itemBackgroundColor
        
        titleLabel.font = Font.regularSmallXL
        titleLabel.textColor = .textColor
        titleLabel.numberOfLines = .zero
        
        dateLabel.font = Font.regularSmallL
        dateLabel.textColor = .notActiveTextColor
        dateLabel.numberOfLines = .zero
    }
    
    private func setupConstraints() {
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Size.smallL)
            make.horizontalEdges.equalToSuperview().inset(Size.smallL)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Size.smallXL)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleView.snp.leading).offset(Size.smallL)
            make.top.equalTo(titleView.snp.bottom).offset(Size.smallS)
            make.bottom.equalToSuperview()
        }
    }
}

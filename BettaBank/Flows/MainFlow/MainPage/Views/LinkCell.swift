//
//  LinkCell.swift
//  BettaBank
//
//  Created by Egor Kruglov on 29.11.2023.
//

import UIKit

class LinkCell: UITableViewCell {

    // MARK: - external dependencies
    
    var text: String? {
        didSet {
            titleLabel.text = text
        }
    }

    // MARK: - ui elements
    
    private let titleLabel = UILabel()
    private let image = UIImageView()

    // MARK: - initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ui setup
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(image)
        
        titleLabel.font = Font.mediumSmallXL
        image.contentMode = .scaleAspectFit
        image.image = UIImage.chevronRight
        image.tintColor = UIColor.textColor
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(Size.smallL)
        }
        
        image.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
    }
}

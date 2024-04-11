//
//  CardInfoDescriptionCustomCell.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 17.12.2023.
//

import UIKit

final class CustomChosenCardInfoCell: UITableViewCell {

    //  MARK: - UI properties

    private let titleLabel = UILabel()
    private let rightSideImage = UIImageView()
    private let blockCardSwitcher = CustomUISliderForCardInfoView()

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        rightSideImage.isHidden = false
        blockCardSwitcher.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Public Methods

    func configure(_ text: String, _ image: ImageResource?) {
        self.titleLabel.text = text
        if let image {
            self.rightSideImage.image = UIImage(resource: image)
        }
    }
    
    func cardIsBlocked(_ indexPath: Int, _ isBlocked: Bool) {
        if indexPath == .zero {
            blockCardSwitcher.isHidden = false
            rightSideImage.isHidden = true
            blockCardSwitcher.setupSliderIf(isBlocked: isBlocked)
        }
    }

    //  MARK: - setup UI

    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
    }
        
    private func addViews() {
        self.addSubview(titleLabel)
        self.addSubview(rightSideImage)
        self.addSubview(blockCardSwitcher)
    }
    
    private func setupViews() {
        titleLabel.font = Font.regularSmallXL
        rightSideImage.contentMode = .scaleAspectFit
        blockCardSwitcher.isHidden = true
        self.layoutIfNeeded()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Size.smallXL)
            make.top.equalToSuperview().offset(Size.smallM)
            make.bottom.equalToSuperview().inset(Size.smallM)
        }
        rightSideImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Size.smallXL)
            make.top.bottom.equalTo(titleLabel)
        }
        blockCardSwitcher.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Size.smallXL)
            make.top.bottom.equalTo(titleLabel)
            make.width.equalTo(Size.largeXL)
        }
    }
}

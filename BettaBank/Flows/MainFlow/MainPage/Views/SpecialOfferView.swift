//
//  SpecialOfferView.swift
//  BettaBank
//
//  Created by Egor Kruglov on 27.11.2023.
//

import UIKit

final class SpecialOfferView: UIView {

    // MARK: - ui elements
    
    private let imageView = UIImageView()
    private let specialOfferTitleLabel = UILabel()
    
    private let firstParameterTitle = UILabel()
    private let secondParameterTitle = UILabel()
    private let thirdParameterTitle = UILabel()
    private lazy var titles = [
        firstParameterTitle,
        secondParameterTitle,
        thirdParameterTitle
    ]
    
    private let firstParameterValue = UILabel()
    private let secondParameterValue = UILabel()
    private let thirdParameterValue = UILabel()
    private lazy var values = [
        firstParameterValue,
        secondParameterValue,
        thirdParameterValue
    ]
    
    private lazy var titlesAndValuesStack = getTitlesAndValuesStack(titles: titles, values: values)

    // MARK: - initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - setup UI
    
    private func setup() {
        addViews()
        setUpView()
        setupConstraints()
    }
    
    private func addViews() {
        [imageView, specialOfferTitleLabel, titlesAndValuesStack].forEach { addSubview($0) }
    }
    
    private func setUpView() {
        backgroundColor = UIColor.itemBackgroundColor
        layer.cornerRadius = Size.smallXL
        
        imageView.image = UIImage(resource: .specialOfferLogo)
        imageView.contentMode = .scaleAspectFit
        
        specialOfferTitleLabel.font = Font.mediumSmallXL
        specialOfferTitleLabel.text =  MainPageTextLabels.specialOfferTitle
        
        titles.forEach { label in
            label.font = Font.regularSmallXL
            label.textColor = UIColor.textColor
        }
        
        values.forEach { label in
            label.font = Font.mediumSmallXL
            label.textColor = .black
            label.textAlignment = .right
        }
        
        firstParameterTitle.text = MainPageTextLabels.firstParameterTitle
        secondParameterTitle.text = MainPageTextLabels.secondParameterTitle
        thirdParameterTitle.text = MainPageTextLabels.thirdParameterTitle
        firstParameterValue.text = MainPageTextLabels.firstParameterValue
        secondParameterValue.text = MainPageTextLabels.secondParameterValue
        thirdParameterValue.text = MainPageTextLabels.thirdParameterValue
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(Size.smallXL)
            make.size.equalTo(Size.middleXL)
        }
        
        specialOfferTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(Size.smallXL)
            make.centerY.equalTo(imageView)
        }
        
        titlesAndValuesStack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(imageView.snp.bottom).offset(Size.smallXL)
            make.bottom.equalToSuperview().inset(Size.smallXL)
        }
    }
}

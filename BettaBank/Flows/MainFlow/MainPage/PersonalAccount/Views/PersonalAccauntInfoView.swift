//
//  File.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 29.11.2023.
//

import UIKit

final class PersonalAccountInfoOnWhiteBackgroundView: UIView {
    
    //  MARK: - UI properties
    
    var onViewDidTap: (() -> Void)?
    
    private let descriptionTitleLabel = UILabel()
    private let descriptionContentLabel = UILabel()

    //  MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        gestureTapOnView()
    }
    
    private func addViews() {
        self.addSubview(descriptionTitleLabel)
        self.addSubview(descriptionContentLabel)
    }
    
    private func setupConstraintsOnWhiteBackground() {
        descriptionTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Size.smallXL)
            make.top.equalToSuperview().offset(Size.smallM)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().inset(Size.smallM)
        }
        descriptionContentLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Size.smallXL)
            make.top.equalToSuperview().offset(Size.smallM)
            make.bottom.equalToSuperview().inset(Size.smallM)
        }
    }
    
    private func setupConstraintsWithoutBackground() {
        descriptionTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Size.smallXL)
            make.top.equalToSuperview().offset(Size.smallM)
            make.width.equalToSuperview()
        }
        descriptionContentLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitleLabel.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().inset(Size.smallXL)
            make.bottom.equalToSuperview().inset(Size.smallM)
        }
    }
    
    func setupViewsOnWhiteBackground(title: String, content: String = "") {
        setupConstraintsOnWhiteBackground()
        self.backgroundColor = .white
        descriptionTitleLabel.text = title
        descriptionContentLabel.text = content
        descriptionTitleLabel.font = Font.regularSmallXL
    }
    
    func setupViewsWithoutBackground(title: String, content: String) {
        setupConstraintsWithoutBackground()
        descriptionTitleLabel.text = title
        descriptionTitleLabel.textColor = .systemGray3
        descriptionContentLabel.text = content
        descriptionContentLabel.font = Font.mediumSmallXL
    }
    
    private func gestureTapOnView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        gesture.numberOfTapsRequired = 1
        isUserInteractionEnabled = true
        addGestureRecognizer(gesture)
    }
    
    @objc private func viewTapped() {
        onViewDidTap?()
    }
}

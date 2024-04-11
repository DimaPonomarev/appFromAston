//
//  BankInfoView.swift
//  BettaBank
//
//  Created by Борис Кравченко on 06.12.2023.
//

import UIKit
import SnapKit

struct BankBranchInfo {
    let latitude: Double
    let longitude: Double
    let name: String
    let address: String
    let workingHours: String
    let isOpenNow: Bool
    let learnMoreURL: URL?
    let distance: String
}

private enum Constants {
    static let isOpenBackWidth: CGFloat = 228
}

final class BankInfoView: UIView {

    // MARK: - UI components

    let closeButton = UIButton()
    let name = UILabel()
    let address = UILabel()
    let workingHours = UILabel()
    let isOpenNow = UILabel()
    let isOpenNowBackgroundImage = UIImageView()
    let iconsStackView = UIStackView()
    let walkingMan = UIImageView()
    let distanceLabel = UILabel()
    let directionImage = UIImageView()
    let learnMoreURL = UIButton()

    // MARK: - lifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addViews()
        setupViews()
        makeConstraints()
        addActions()
        configure(with: BankBranchInfo(
            latitude: MapCoordinates.startLatitude,
            longitude: MapCoordinates.startLongitude,
            name: "",
            address: "",
            workingHours: "",
            isOpenNow: true,
            learnMoreURL: URL(string: ""),
            distance: ""
        ))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Configure

    func configure(with branchInfo: BankBranchInfo) {
        name.text = branchInfo.name
        address.text = branchInfo.address
        workingHours.text = branchInfo.workingHours
        distanceLabel.text = branchInfo.distance
        isOpenNow.text = branchInfo.isOpenNow ? BankViewTextConstants.NowOpen : BankViewTextConstants.NowClose
        learnMoreURL.setTitle(BankViewTextConstants.LearnMore, for: .normal)
    }

    func addViews() {
        addSubview(name)
        addSubview(closeButton)
        addSubview(address)
        addSubview(workingHours)
        addSubview(isOpenNowBackgroundImage)
        addSubview(isOpenNow)
        addSubview(iconsStackView)
        addSubview(walkingMan)
        addSubview(distanceLabel)
        addSubview(directionImage)
        addSubview(learnMoreURL)
    }

    func setupViews() {
        name.font = Font.boldSmallXL
        closeButton.setImage(UIImage(resource: .clear), for: .normal)
        address.font = Font.regularSmallXL
        workingHours.font = Font.regularSmallXL

        isOpenNowBackgroundImage.layer.backgroundColor = UIColor.bankAddressViewColor
        isOpenNowBackgroundImage.layer.cornerRadius = Size.middleS
        isOpenNowBackgroundImage.layer.masksToBounds = true

        isOpenNow.font = Font.boldSmallL
        isOpenNow.textColor = .systemGreen
        walkingMan.image = UIImage(resource: .directionsWalk)
        distanceLabel.font = Font.regularSmallXL
        directionImage.image = UIImage(resource: .directionIcon)

        setupIconsStackView()
    }

    func setupIconsStackView() {
        iconsStackView.axis = .horizontal
        iconsStackView.spacing = Size.smallXL
        iconsStackView.alignment = .top

        let iconImages: [String] = ["sendIcon", "payIcon", "currencyIcon", "cashIcon", "billIcon"]
        for imageName in iconImages {
            let imageView = UIImageView(image: UIImage(named: imageName))
            iconsStackView.addArrangedSubview(imageView)
        }
    }

    func makeConstraints() {
        name.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Size.smallXL)
            make.leading.equalToSuperview().inset(Size.smallXL)
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Size.smallM)
            make.trailing.equalToSuperview().offset(-Size.smallM)
        }
        address.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(Size.smallM)
            make.leading.equalToSuperview().inset(Size.smallXL)
        }
        workingHours.snp.makeConstraints { make in
            make.top.equalTo(address.snp.bottom).offset(Size.smallXL)
            make.leading.equalToSuperview().inset(Size.smallXL)
        }
        isOpenNow.snp.makeConstraints { make in
            make.centerY.equalTo(workingHours.snp.centerY)
            make.leading.equalTo(workingHours.snp.trailing).offset(Size.smallXL)
        }
        isOpenNowBackgroundImage.snp.makeConstraints { make in
            make.centerY.equalTo(isOpenNow.snp.centerY)
            make.centerX.equalTo(isOpenNow.snp.centerX)
            make.leading.equalTo(isOpenNow.snp.leading).offset(-Size.smallL)
            make.trailing.equalTo(isOpenNow.snp.trailing).offset(Size.smallL)
            make.height.equalTo(Size.middleXL)
        }
        iconsStackView.snp.makeConstraints { make in
            make.top.equalTo(isOpenNow.snp.bottom).offset(Size.smallXL)
            make.leading.equalToSuperview().inset(Size.smallXL)
        }
        walkingMan.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(iconsStackView.snp.bottom).offset(Size.smallXL)
        }
        distanceLabel.snp.makeConstraints { make in
            make.leading.equalTo(walkingMan.snp.trailing)
            make.top.equalTo(iconsStackView.snp.bottom).offset(Size.smallXL)
        }
        directionImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-Size.smallXL)
            make.top.equalTo(iconsStackView.snp.centerY)
            make.size.equalTo(Size.largeXL)
        }
        learnMoreURL.snp.makeConstraints { make in
            make.top.equalTo(walkingMan.snp.bottom).offset(Size.smallXL)
            make.centerX.equalToSuperview()
        }
    }

    func addActions() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        learnMoreURL.setTitle(BankViewTextConstants.LearnMore, for: .normal)
        learnMoreURL.setTitleColor(.black, for: .normal)
        learnMoreURL.titleLabel?.font = Font.mediumSmallXL
    }

    // MARK: - @objc funcs

    @objc private func closeButtonTapped() {
        removeFromSuperview()
    }
}

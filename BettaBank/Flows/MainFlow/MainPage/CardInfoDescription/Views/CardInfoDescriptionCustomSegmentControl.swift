//
//  CardInfoDescriptionCustomSegmentControl.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 17.12.2023.
//

import UIKit

private enum Constants {
    static let underlineViewColor = UIColor(red: 1, green: 0.839, blue: 0, alpha: 1)
    static let underlineViewHeight: CGFloat = 3
    static let oneThirdSegmentedControlWidth = 0.35
    static let halfTheWidthOfSelectedSegment = 0.5
    static let durationOfAnimation = 0.3
    static let widthOfWhiteBackgroundColor: CGFloat = 1
    static let informationTitle = "Информация"
    static let managementTitle = "Управление"
}

final class CustomSegmentControl: UIView {
    
    //  MARK: - UI properties
    
    private let segmentedControl = UISegmentedControl()
    private let bottomUnderlineView = UIView()
    
    var showInformationTableView: (() -> Void)?
    var showManagementTableView: (() -> Void)?
    
    //  MARK: - init
    
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
        setupViews()
        setupConstraints()
    }

    private func addViews() {
        self.addSubview(segmentedControl)
        self.addSubview(bottomUnderlineView)
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        bottomUnderlineView.backgroundColor = .yellowButtonColor
        
        segmentedControl.insertSegment(withTitle: Constants.informationTitle, at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: Constants.managementTitle, at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = .zero
        let viewOfSelectedSegment = segmentedControl.subviews[.zero]
        viewOfSelectedSegment.isHidden = true
        segmentedControl.setTitleTextAttributes([
            .foregroundColor: UIColor.black,
            .font: Font.regularSmallXL], for: .normal)
        segmentedControl.setTitleTextAttributes([
            .foregroundColor: UIColor.black,
            .font: Font.regularSmallXL], for: .selected)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.setBackgroundImage(makeImageWithWhiteColor(), for: .normal, barMetrics: .default)
    }
    
    private func setupConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.leading.centerX.centerY.equalToSuperview()
        }
        bottomUnderlineView.snp.makeConstraints { make in
            make.bottom.equalTo(segmentedControl.snp.bottom)
            make.height.equalTo(Constants.underlineViewHeight)
            make.width.equalTo(segmentedControl.snp.width).multipliedBy(Constants.oneThirdSegmentedControlWidth)
            make.centerX.equalTo(segmentedControl.snp.centerX).multipliedBy(Constants.halfTheWidthOfSelectedSegment)
        }
    }
    
    //  MARK: - private methods
    
    private func changeSegmentedControlLinePosition() {
        let segmentIndex = CGFloat(segmentedControl.selectedSegmentIndex)
        let centerOfSelectedSegmentMultiplier = segmentIndex + Constants.halfTheWidthOfSelectedSegment
        UIView.animate(withDuration: Constants.durationOfAnimation, animations: {
            self.bottomUnderlineView.snp.remakeConstraints { make in
                make.bottom.equalTo(self.segmentedControl.snp.bottom)
                make.height.equalTo(Constants.underlineViewHeight)
                make.width.equalTo(self.segmentedControl.snp.width).multipliedBy(Constants.oneThirdSegmentedControlWidth)
                make.centerX.equalTo(self.segmentedControl.snp.centerX).multipliedBy(centerOfSelectedSegmentMultiplier)
            }
            self.layoutIfNeeded()
        })
    }
    
    private func makeImageWithWhiteColor() -> UIImage {
        let rect = CGRect(x: .zero, y: .zero, width: Constants.widthOfWhiteBackgroundColor, height: segmentedControl.intrinsicContentSize.height)
        UIGraphicsBeginImageContext(rect.size)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        context.setFillColor(UIColor.white.cgColor)
        context.fill(rect)
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
    
    //  MARK: - objc methods
    
    @objc private func segmentedControlValueChanged() {
        
        if segmentedControl.selectedSegmentIndex == .zero {
            showManagementTableView?()
        } else {
            showInformationTableView?()
        }
        changeSegmentedControlLinePosition()
    }
}

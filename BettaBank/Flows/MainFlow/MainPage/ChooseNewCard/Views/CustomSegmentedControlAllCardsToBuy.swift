//
//  CustomSegmentedControlAllCardsToBuy.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 24.01.2024.
//

import UIKit

final class CustomSegmentedControlAllCardsToBuy: UIView {
    
    //  MARK: - UI properties
    
    private let segmentedControl = UISegmentedControl()
    var valueChangedClosure: ((Int) -> Void)?
    
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
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        segmentedControl.tintColor = .black
        segmentedControl.insertSegment(withTitle: ChooseNewCardModel.TypeOfCard.debit.rawValue, at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: ChooseNewCardModel.TypeOfCard.credit.rawValue, at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = .zero
        segmentedControl.setTitleTextAttributes([
            .foregroundColor: UIColor.black,
            .font: Font.regularSmallXL], for: .normal)
        segmentedControl.setTitleTextAttributes([
            .foregroundColor: UIColor.black,
            .font: Font.boldSmallXL], for: .selected)
        segmentedControl.selectedSegmentTintColor = .yellowButtonColor
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    private func setupConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    //  MARK: - objc methods
    
    @objc private func segmentedControlValueChanged() {
        self.valueChangedClosure?(segmentedControl.selectedSegmentIndex)
    }
}

//
//  NotificationsView.swift
//  BettaBank
//
//  Created by Dzhami on 13.12.2023.
//

import UIKit

final class NotificationSettingsView: UIView {
    
    var onSwitchTap: (() -> Void)?
    
    private var editButton = UIButton()
    private var iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private var switchView = UISwitch()
    
    //  MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setUpConstraints()
        setUpCell()
    }
    
    private func addViews() {
        self.addSubview(iconImageView)
        self.addSubview(titleLabel)
        self.addSubview(switchView)
        self.addSubview(editButton)
    }
    
    private func setUpCell() {
        editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        editButton.tintColor = .black
        editButton.addTarget(self, action: #selector(switchChanged), for: .touchUpInside)
        switchView.onTintColor = .yellowButtonColor
    }
    
    private func setUpConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Size.smallXL)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(Size.middleM)
            make.top.bottom.equalToSuperview().inset(Size.smallXL)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(Size.smallXL)
            make.centerY.equalToSuperview()
        }
        
        editButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-Size.smallXL)
            make.centerY.equalToSuperview()
        }
        
        switchView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-Size.smallXL)
            make.centerY.equalToSuperview()
            
        }
    }
    
    func configure(icon: UIImage, title: String, showEditButton: Bool) {
        iconImageView.image = icon
        titleLabel.text = title
        
        if showEditButton {
            // Показываем кнопку редактирования
            switchView.isHidden = true
            editButton.isHidden = false
        } else {
            // Показываем переключатель
            switchView.isHidden = false
            editButton.isHidden = true
        }
    }

    // MARK: - @objc func
    
    @objc func switchChanged() {
        onSwitchTap?()
    }
}

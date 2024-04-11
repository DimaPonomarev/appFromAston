//
//  ServerErrorViewController.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 23.11.2023.
//

import UIKit
import SnapKit

private enum Constants {
    static let titleText = "Отсутствует соединение с сервером"
    static let descriptionText = "При загрузке данных произошла ошибка. Повторите попытку позже."
    
    static let numberOfLines = 2
}

final class ServerErrorViewController: UIViewController {
        
    //  MARK: - UI properties
    private let titleView = UIView()
    private let titleLabel = UILabel()
    private let iconImageView = UIImageView()
    private let descriptionLabel = UILabel()

    //  MARK: - life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
    }
        
    private func addViews() {
        view.addSubview(titleView)
        
        [titleLabel, iconImageView, descriptionLabel].forEach {
            titleView.addSubview($0)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .mainBackgroundColor
        
        iconImageView.image = UIImage(resource: .warningIcon)
        
        titleLabel.text = Constants.titleText
        titleLabel.font = Font.mediumMiddleM
        titleLabel.numberOfLines = Constants.numberOfLines
        titleLabel.textColor = .textColor
        
        descriptionLabel.text = Constants.descriptionText
        descriptionLabel.font = Font.regularSmallXL
        descriptionLabel.numberOfLines = Constants.numberOfLines
        descriptionLabel.textColor = .textColor
    }
        
    private func setupConstraints() {
        titleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(Size.smallXL)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Size.smallS)
            make.top.equalToSuperview().offset(Size.smallS)
            make.height.equalTo(Size.largeM)
            make.height.equalTo(iconImageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(Size.smallL)
            make.top.equalToSuperview().offset(Size.smallS)
            make.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(Size.smallL)
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}

//
//  WelcomeView.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 27.11.2023.
//

import UIKit
import SnapKit

private enum Constants {
    static let logoHeight: CGFloat = 112
    static let preloaderHeight: CGFloat = 132

    static let degree: CGFloat = .init(Double.pi)
    static let rotationAnimationKey = "rotationanimationkey"
    static let animationDuration: TimeInterval = 1
}

final class WelcomeView: UIView {
    var animationFinished: (() -> Void)?
    
    private let logoImageView = UIImageView()
    private let titleLabel = UILabel()
    private let preloaderImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        animateLoader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addViews()
        addConstraints()
        configureViews()
    }
    
    private func addViews() {
        [logoImageView, titleLabel, preloaderImageView].forEach {
            addSubview($0)
        }
    }
    
    private func addConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.logoHeight)
            make.width.equalTo(logoImageView.snp.height)
            make.bottom.equalTo(titleLabel.snp.top).inset(-Size.middleXL)
        }
        
        preloaderImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(Size.middleXL * 2)
            make.height.equalTo(Constants.preloaderHeight)
            make.width.equalTo(preloaderImageView.snp.height)
        }
    }
    
    private func configureViews() {
        backgroundColor = .white
        
        logoImageView.image = UIImage(named: "Logo")
        logoImageView.contentMode = .scaleAspectFit
        
        preloaderImageView.image = UIImage(named: "Loader")
        preloaderImageView.contentMode = .scaleAspectFit
        
        titleLabel.text = "Бетта-Банк".localized()
        titleLabel.font = Font.mediumMiddleM
    }
    
    private func animateLoader() {
        preloaderImageView.addRotationAnimtation(duration: Constants.animationDuration, completion: { [weak self] in
            self?.animationFinished?()
        })
    }
}

private extension UIView {
    func addRotationAnimtation(duration: Double, completion: @escaping () -> Void) {
        guard layer.animation(forKey: Constants.rotationAnimationKey) == nil else {
            return
        }
        
        CATransaction.begin()
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")

        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Float.pi * 2.0
        rotationAnimation.duration = duration
        rotationAnimation.autoreverses = true
        rotationAnimation.repeatCount = 1

        CATransaction.setCompletionBlock(completion)
        layer.add(rotationAnimation, forKey: Constants.rotationAnimationKey)
        
        CATransaction.commit()
    }
}

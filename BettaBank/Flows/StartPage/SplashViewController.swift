//
//  SplashViewController.swift
//  MRN Coordinator
//
//  Created by Margarita Slesareva on 04.11.2023.
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

final class SplashViewController: UIViewController {
    private let splashViewModel: SplashViewModel
    
    private let welcomeView = WelcomeView()
    private var rotationDegree = Constants.degree
    
    init(splashViewModel: SplashViewModel) {
        self.splashViewModel = splashViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        addConstraints()
        configureViews()
    }
    
    private func addViews() {
        view.addSubview(welcomeView)
    }
    
    private func addConstraints() {
        welcomeView.snp.makeConstraints { make in
            make.horizontalEdges.greaterThanOrEqualToSuperview().inset(Size.smallXL)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        
        welcomeView.animationFinished = splashViewModel.animatedLoader
    }
}

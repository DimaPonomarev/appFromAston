//
//  TabBarViewController.swift
//  BettaBank
//
//  Created by Egor Kruglov on 08.11.2023.
//

import UIKit

protocol TabBarViewControllerProtocol {
    var viewModel: TabBarViewModel { get }
}

final class TabBarViewController: UITabBarController, TabBarViewControllerProtocol {
    
    //  MARK: External dependencies

    var viewModel: TabBarViewModel

    // MARK: - Inits
    
    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(String(describing: Self.self) + " was deinited")
    }
    
    //  MARK: - life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        setupViews()
    }
    
    private func setupViews() {
        tabBar.tintColor = UIColor.tabBarActiveColor
        tabBar.unselectedItemTintColor = UIColor.tabBarInactiveColor
        tabBar.backgroundColor = .white
    }
}

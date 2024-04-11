//
//  AccountViewController.swift
//  BettaBank
//
//  Created by Dzhami on 18.12.2023.
//

import UIKit

final class AccountViewController: UIViewController {
    
    //  MARK: External dependencies

    var viewModel: AccountViewModelProtocol
    
    //  MARK: - UI properties
    
    private let accountView = AccountView()
    
    //  MARK: - init
    
    init(viewModel: AccountViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        accountView.configureDepositScreen(model: viewModel.model)
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
        setupBackNavigationButton(type: .pop)
    }
        
    private func addViews() {
        view.addSubview(accountView)
    }
    
    private func setupViews() {
        view.backgroundColor = .itemBackgroundColor
        
        self.title = DepositStringValue.accountMainLabel
    }
        
    private func setupConstraints() {
        accountView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
        
    //  MARK: - private methods

    //  MARK: - objc method
    
}

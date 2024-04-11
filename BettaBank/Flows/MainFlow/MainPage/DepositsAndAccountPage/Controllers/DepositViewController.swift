//
//  DepositViewController.swift
//  BettaBank
//
//  Created by Dzhami on 18.12.2023.
//

import UIKit

final class DepositViewController: UIViewController {
    
    //  MARK: External dependencies
    
    var viewModel: DepositViewModelProtocol
    
    //  MARK: - UI properties
    
    private let depositView = DepositView()
    private let model: DepositFullInfoModel
    
    //  MARK: - init
    
    init(viewModel: DepositViewModelProtocol, model: DepositFullInfoModel) {
        self.viewModel = viewModel
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        depositView.configureDepositScreen(model: model)
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
        setupBackNavigationButton(type: .pop)
    }
    
    private func addViews() {
        view.addSubview(depositView)
    }
    
    private func setupViews() {
        view.backgroundColor = .itemBackgroundColor
        
        self.title = DepositStringValue.depositeLabel
    }
    
    private func setupConstraints() {
        depositView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        //  MARK: - private methods
        
        //  MARK: - objc method
        
    }
}

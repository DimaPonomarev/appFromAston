//
//  CustomerLoanViewController.swift
//  BettaBank
//
//  Created by Софья Норина on 29.11.2023.
//

import SnapKit
import UIKit

private enum Constants {
    static let loanIconWidth = 70
}

final class FullInfoLoanViewController: UIViewController {
    
    //  MARK: - external dependencies
    
    private let viewModel: LoansViewModelProtocol
    
    //  MARK: - UI properties
    
    private let loanView = LoanView()
    private let loanModel: LoanFullInfoModel
    
    //  MARK: - private properties
    
    init(viewModel: LoansViewModelProtocol, loanModel: LoanFullInfoModel) {
        self.viewModel = viewModel
        self.loanModel = loanModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loanView.configureDepositScreen(model: loanModel)
        setupBackNavigationButton(type: .pop)
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
    }
    
    private func addViews() {
        view.addSubview(loanView)
    }
    
    private func setupViews() {
        view.backgroundColor = .itemBackgroundColor
        navigationController?.navigationBar.tintColor = .textFieldPlaceholder
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        title = LoanStringValue.loanTitle
    }
    
    private func setupConstraints() {
        loanView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

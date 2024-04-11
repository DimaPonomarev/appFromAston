//
//  LoansViewController.swift
//  BettaBank
//
//  Created by Софья Норина on 29.11.2023.
//

import UIKit

final class LoansViewController: UIViewController {
    
    //  MARK: External dependencies
    
    private let viewModel: LoansViewModelProtocol
    
    //  MARK: - UI properties
    
    private let tableView = UITableView()
    
    //  MARK: - init
    
    init(viewModel: LoansViewModelProtocol) {
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
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
        setupBackNavigationButton(type: .pop)
    }
    
    private func addViews() {
        view.backgroundColor = .itemBackgroundColor
        view.addSubview(tableView)
    }
    
    private func setupViews() {
        title = LoanStringValue.loansTitle
        tableView.register(TemplateViewCell.self, forCellReuseIdentifier: TemplateViewCell.identifier)
        tableView.backgroundColor = .itemBackgroundColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func barButtonItemTapped() {
        viewModel.dismissLoan(viewController: self)
    }
}

extension LoansViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.loanData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TemplateViewCell.identifier, for: indexPath)
                as? TemplateViewCell
        else {
            return UITableViewCell()
        }
        cell.configureLoanCell(model: viewModel.loanData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.sendData(for: indexPath)
    }
}

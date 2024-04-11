//
//  DepositAndAccountViewController.swift
//  BettaBank
//
//  Created by Софья Норина on 5.12.2023.
//

import UIKit
import SnapKit

final class DepositAndAccountViewController: UIViewController {
    
    //  MARK: - external dependencies
    
    private let viewModel: DepositAndAccountViewModelProtocol
    
    //  MARK: - UI properties
    private let depositHaderView = UIView()
    private let accountHeaderView = UIView()
    private let tableView = UITableView()
    private let depositSectionTitle = UILabel()
    private let accountSectionTitle = UILabel()
    
    //  MARK: - init
    
    init(viewModel: DepositAndAccountViewModelProtocol) {
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
        view.addSubview(tableView)
        tableView.addSubview(depositHaderView)
        tableView.addSubview(accountHeaderView)
        depositHaderView.addSubview(depositSectionTitle)
        accountHeaderView.addSubview(accountSectionTitle)
    }
    
    private func setupViews() {
        title = DepositStringValue.title
        view.backgroundColor = .itemBackgroundColor
        tableView.backgroundColor = .itemBackgroundColor
        tableView.register(TemplateViewCell.self, forCellReuseIdentifier: TemplateViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        depositSectionTitle.textColor = .textColor
        depositSectionTitle.font = Font.regularSmallXL
        depositSectionTitle.text = DepositStringValue.depositeLabel
        
        accountSectionTitle.textColor = .textColor
        accountSectionTitle.font = Font.regularSmallXL
        accountSectionTitle.text = DepositStringValue.accountLabel
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        depositSectionTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
        accountSectionTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(Size.smallXL)
        }
    }
}

extension DepositAndAccountViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            viewModel.depositData.count
        } else {
            viewModel.accountData.count
        }
    }
    
    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return depositHaderView
        } else {
            return accountHeaderView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TemplateViewCell.identifier, for: indexPath) as? TemplateViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0:
            cell.configureDepositCell(model: viewModel.depositData[indexPath.row])
        case 1:
            cell.configureAccountCell(model: viewModel.accountData[indexPath.row])
        default:
            return cell
        }
        return cell
    }
}

extension DepositAndAccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.sendData(for: indexPath)
    }
}

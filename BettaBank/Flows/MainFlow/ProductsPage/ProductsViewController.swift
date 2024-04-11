//
//  ProductsViewController.swift
//  BettaBank
//
//  Created by Софья Норина on 9.11.2023.
//
//Пример вызова LoansViewCell
//PersonalLoanModel(productName: "Betta потребительский",
//                  countLabel: 500000000,
//                  openLabel: "17.12.2022",
//                  percent: "6.4 % годовых",
//                  type: .loan,
//                  statusType: .active)

import UIKit
import SnapKit

private enum Constants {
    static let pageTitle = "Мои продукты"
    static let applicationButtonTittle = "Мои заявки"
    static let noDataTitle = "На данный момент у Вас отсутствуют действующие кредитные продукты"
    static let noDataImageName = "Logo"
    static let bankLogoTitle = "Бетта-Банк"
    
    static let applicationButtonWidth = 140
    static let logoImageWidth = 57
    static let logoImageHeight = 72
}

final class ProductsViewController: UIViewController {
    
    //  MARK: - external dependencies
    
    private let viewModel: ProductsViewModelProtocol
    
    //  MARK: - UI properties
    
    private let tableView = UITableView()
    
    private lazy var segmentControl: UISegmentedControl = {
        UISegmentedControl(items: viewModel.getProductTypes())
    }()
    private let myApplicationButton = UIButton()
    private let noDataLabel = UILabel()
    private let noDataImage = UIImageView()
    private let bankNameLabel = UILabel()
    
    //  MARK: - init
    
    init(viewModel: ProductsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    //  MARK: - setup UI
    
    private func setUp() {
        addViews()
        addConstrains()
        setupViews()
        setupSegmentControl()
        checkDataAndShowLabel()
    }
    
    private func addViews() {
        view.addSubview(tableView)
        view.addSubview(myApplicationButton)
        view.addSubview(segmentControl)
        view.addSubview(noDataLabel)
        view.addSubview(noDataImage)
        view.addSubview(bankNameLabel)
    }
    
    private func addConstrains() {
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Size.smallXL)
            make.horizontalEdges.equalToSuperview().inset(Size.smallXL)
        }
        
        myApplicationButton.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(Size.smallXL)
            make.trailing.equalToSuperview().inset(Size.smallXL)
            make.width.equalTo(Constants.applicationButtonWidth)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(myApplicationButton.snp.bottom)
            make.bottom.horizontalEdges.equalToSuperview()
        }
        
        noDataImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(Constants.logoImageWidth)
            make.height.equalTo(Constants.logoImageHeight)
        }
        
        bankNameLabel.snp.makeConstraints { make in
            make.top.equalTo(noDataImage.snp.bottom).offset(Size.smallXL)
            make.centerX.equalToSuperview()
        }
        
        noDataLabel.snp.makeConstraints { make in
            make.top.equalTo(bankNameLabel.snp.bottom).offset(Size.middleS)
            make.horizontalEdges.equalToSuperview().inset(Size.largeXL)
        }
    }
    
    private func setupSegmentControl() {
        segmentControl.addTarget(self, action: #selector(segmentContorlValueChanged(_:)), for: .valueChanged)
        segmentControl.selectedSegmentIndex = viewModel.getCurrentProductType().rawValue
    }
    
    private func setupViews() {
        title = Constants.pageTitle
        view.backgroundColor = .mainBackgroundColor
        
        tableView.register(AccountViewCell.self, forCellReuseIdentifier: AccountViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .mainBackgroundColor
        tableView.separatorStyle = .none
        
        myApplicationButton.setTitle(Constants.applicationButtonTittle, for: .normal)
        myApplicationButton.titleLabel?.font = Font.regularSmallL
        myApplicationButton.backgroundColor = .yellowButtonColor
        myApplicationButton.setTitleColor(.textColor, for: .normal)
        myApplicationButton.layer.cornerRadius = Size.smallM
        myApplicationButton.addTarget(self, action: #selector(myApplicationButtonTapped), for: .touchUpInside)
        
        noDataLabel.text = Constants.noDataTitle
        noDataLabel.font = Font.regularSmallL
        noDataLabel.textAlignment = .center
        noDataLabel.numberOfLines = 2
        
        noDataImage.image = UIImage(resource: Constants.noDataImageName)
        
        bankNameLabel.text = Constants.bankLogoTitle
        bankNameLabel.font = Font.regularMiddleXL
    }
    
    //  MARK: - private func
    
    private func checkDataAndShowLabel() {
        if viewModel.accountData.isEmpty {
            tableView.isHidden = true
            noDataLabel.isHidden = false
            noDataImage.isHidden = false
            bankNameLabel.isHidden = false
        } else {
            tableView.isHidden = false
            noDataLabel.isHidden = true
            noDataImage.isHidden = true
            bankNameLabel.isHidden = true
        }
    }
    
    // MARK: - objc methods
    
    @objc private func myApplicationButtonTapped() {
        viewModel.showApplication()
    }
    
    @objc private func segmentContorlValueChanged(_ sender: UISegmentedControl) {
        viewModel.setCurrentProductType(index: sender.selectedSegmentIndex)
        tableView.reloadData()
    }
}

extension ProductsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCountAccountModel()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountViewCell.identifier, for: indexPath)
                as? AccountViewCell else {
            return UITableViewCell()
        }
        cell.configure(model: viewModel.getCurrentAccountModel(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellDidTapped(indexPath: indexPath)
    }
}

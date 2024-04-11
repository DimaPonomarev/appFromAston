//
//  ProductRequisitionListViewController.swift
//  BettaBank
//
//  Created by Vadim Blagodarny on 29.12.2023.
//

import UIKit

private enum Constants {
    static let cellId = "ProductRequisitionListCell"
    static let title = "Мои заявки"
}

final class ProductRequisitionListViewController: UIViewController {
    
    // MARK: - external dependencies

    private let viewModel: ProductRequisitionListViewModelProtocol
    
    // MARK: - UI properties
    
    private lazy var segmentedControl: UISegmentedControl = {
        UISegmentedControl(items: viewModel.getProductTypes())
    }()
    
    private let tableView = UITableView()
    
    // MARK: - init
    
    init(viewModel: ProductRequisitionListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
    }
        
    private func addViews() {
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        title = Constants.title
        
        navigationController?.navigationBar.tintColor = .textFieldPlaceholder
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        segmentedControl.selectedSegmentIndex = viewModel.getCurrentProductType().rawValue
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        tableView.dataSource = self
        tableView.register(ProductRequisitionListCell.self, forCellReuseIdentifier: Constants.cellId)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false   
    }
        
    private func setupConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(Size.middleS)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(Size.smallXL)
            make.trailing.equalToSuperview().inset(Size.smallXL)
        }
    }
    
    // MARK: - objc methods
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl) {
        viewModel.setCurrentProductType(index: sender.selectedSegmentIndex)
        tableView.reloadData()
    }
}

extension ProductRequisitionListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getProductListFiltered(productType: viewModel.getCurrentProductType()).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as? ProductRequisitionListCell
        let model = viewModel.getProductListFiltered(productType: viewModel.getCurrentProductType())[indexPath.row]
        cell?.configure(model: model,
                        actionClosure: {
            self.viewModel.showDetails(model: model)
        })
        return cell ?? UITableViewCell()
    }
}

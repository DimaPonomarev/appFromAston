//
//  StoryViewController.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 07.12.2023.
//

import UIKit

final class HistoryViewController: UIViewController {
    
    private let viewModel: HistoryViewModelProtocol
    
    //  MARK: - UI properties
    
    private let tableView = UITableView()
    private let firstSectionView = UIView()
    private let secondSectionView = UIView()
    private let firstSectionTitle = UILabel()
    private let secondSectionTitle = UILabel()
    
    //  MARK: - init
    init(viewModel: HistoryViewModelProtocol) {
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
        addConstrains()
        setupViews()
        setupBarButtonItems()
        getAllOperationFromCoreData()
    }
    
    private func addViews() {
        view.addSubview(tableView)
        tableView.addSubview(firstSectionView)
        tableView.addSubview(secondSectionView)
        firstSectionView.addSubview(firstSectionTitle)
        secondSectionView.addSubview(secondSectionTitle)
    }
    
    private func addConstrains() {
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        firstSectionTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Size.middleM)
            make.centerY.equalToSuperview()
        }
        secondSectionTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Size.middleM)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupViews() {
        title = HistoryStringValue.tabBarItemTitle
        view.backgroundColor = .mainBackgroundColor
        tableView.register(HistoryViewCell.self, forCellReuseIdentifier: HistoryViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .close, 
                            target: self,
                            action: #selector(deleteBarButtonDidTapped)),
            UIBarButtonItem(barButtonSystemItem: .add,
                            target: self,
                            action: #selector(addBarButtonDidTapped))
        ]
    }
    
    private func getAllOperationFromCoreData() {
        print("CoreData stores \(viewModel.getAllOperations().count) operations")
    }
    
    @objc private func addBarButtonDidTapped() {
        let operationModels = viewModel.historyData.operations
        operationModels.forEach { operationModel in
            viewModel.saveOperationModel(with: operationModel)
        }
        print("CoreData stores \(viewModel.getAllOperations().count) operations")
    }
    
    @objc private func deleteBarButtonDidTapped() {
        viewModel.deleteAllOperations()
        print("CoreData stores \(viewModel.getAllOperations().count) operations")
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        viewModel.cellTapped(at: indexPath.row)
    }
}

extension HistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            firstSectionTitle.text = HistoryStringValue.firstSectionTitle
            return firstSectionView
        case 1:
            secondSectionTitle.text = HistoryStringValue.secondSectionTitle
            return secondSectionView
        default:
            return .none
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.historyData.operations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryViewCell.identifier, for: indexPath) as? HistoryViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.historyData.operations[indexPath.row])
        return cell
    }
}

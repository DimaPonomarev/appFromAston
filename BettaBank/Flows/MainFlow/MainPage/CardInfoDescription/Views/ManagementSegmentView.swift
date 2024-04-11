//
//  CardInfoDescriptionManagementSegmentView.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 17.12.2023.
//

import UIKit

final class ManagementSegmentView: UIView {
    
    //  MARK: - UI properties
    
    private let managementTableView = UITableView()
    private let viewModel: ChosenCardInfoViewModelProtocol
    
    //  MARK: - init
    
    init(frame: CGRect, viewModel: ChosenCardInfoViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Public methods
    
    func reloadData() {
        managementTableView.reloadData()
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
    }
    
    private func addViews() {
        self.addSubview(managementTableView)
    }
    
    private func setupViews() {
        managementTableView.dataSource = self
        managementTableView.delegate = self
        managementTableView.separatorColor = .clear
        managementTableView.showsVerticalScrollIndicator = false
        managementTableView.isScrollEnabled = false
        managementTableView.register(CustomChosenCardInfoCell.self, forCellReuseIdentifier: CustomChosenCardInfoCell.identifier)
    }
    
    private func setupConstraints() {
        managementTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//  MARK: - extension UITableViewDataSource

extension ManagementSegmentView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInTableView(.management)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomChosenCardInfoCell.identifier, 
                                                       for: indexPath) as? CustomChosenCardInfoCell
        else { return UITableViewCell() }
        
        let textForCell = viewModel.getTitleForCellAt(indexPath.row, .management)
        let iconForCell = viewModel.getIconForCellAt(indexPath.row, .management)
        let isBlockedValue = viewModel.getIsBlockedInfo(indexPath.row)
        cell.configure(textForCell, iconForCell)
        cell.cardIsBlocked(indexPath.row, isBlockedValue)
        
        return cell
    }
}

//  MARK: - extension UITableViewDelegate

extension ManagementSegmentView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.getActionAt(indexPath.row, .management)()
        
    }
}

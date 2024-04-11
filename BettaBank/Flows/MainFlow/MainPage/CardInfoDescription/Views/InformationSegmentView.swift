//
//  CardInfoDescriptionInformationSegmentView.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 17.12.2023.
//

import UIKit

final class InformationSegmentView: UIView {

    //  MARK: - UI properties

    private let informationTableView = UITableView()
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
    
    //  MARK: - setup UI

    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
    }
        
    private func addViews() {
        self.addSubview(informationTableView)
    }
    
    private func setupViews() {
        informationTableView.dataSource = self
        informationTableView.delegate = self
        informationTableView.separatorColor = .clear
        informationTableView.showsVerticalScrollIndicator = false
        informationTableView.isScrollEnabled = false
        informationTableView.register(CustomChosenCardInfoCell.self, forCellReuseIdentifier: CustomChosenCardInfoCell.identifier)
    }
    
    private func setupConstraints() {
        informationTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//  MARK: - extension UITableViewDataSource

extension InformationSegmentView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInTableView(.information)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomChosenCardInfoCell.identifier, 
                                                       for: indexPath) as? CustomChosenCardInfoCell
        else { return UITableViewCell() }
        let textForCell = viewModel.getTitleForCellAt(indexPath.row, .information)
        let iconForCell = viewModel.getIconForCellAt(indexPath.row, .information)
        cell.configure(textForCell, iconForCell)

        return cell
    }
}

//  MARK: - extension UITableViewDelegate

extension InformationSegmentView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.getActionAt(indexPath.row, .information)()
    }
}

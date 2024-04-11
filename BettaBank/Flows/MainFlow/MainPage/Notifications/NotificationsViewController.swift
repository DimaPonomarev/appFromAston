//
//  NotificationsViewController.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 06.12.2023.
//

import UIKit
import SnapKit

private enum Constants {
    static let titleString = "Уведомление"
}

final class NotificationsViewController: UIViewController {
    
    private let notificationDataSource: NotificationDataSourceProtocol
    
    //  MARK: - UI properties
    
    private let tableView = UITableView()
    
    //  MARK: - init
    
    init(notificationDataSource: NotificationDataSourceProtocol) {
        self.notificationDataSource = notificationDataSource
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
        setupBackNavigationButton(type: .dismiss)
    }
        
    private func addViews() {
        view.addSubview(tableView)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        title = Constants.titleString
        
        tableView.dataSource = self
        tableView.register(
            NotificationsTableViewCell.self,
            forCellReuseIdentifier: NotificationsTableViewCell.identifier
        )
        
        tableView.separatorStyle = .none
    }
        
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension NotificationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationDataSource.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: NotificationsTableViewCell.identifier,
                for: indexPath
        ) as? NotificationsTableViewCell else {
            return UITableViewCell()
        }

        let model = notificationDataSource.notifications[indexPath.row]
        
        cell.configure(model: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

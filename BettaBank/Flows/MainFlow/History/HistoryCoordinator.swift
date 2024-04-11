//
//  StoryCoordinator.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 11.12.2023.
//

import UIKit

protocol HistoryOutput {
    func showOperationInfo(at index: Int)
}

final class HistoryCoordinator: TabCoordinator {
    var onStart: (() -> Void)?
    
    func start() {
        onStart?()
        showHistoryScreen()
    }
    
    private func showHistoryScreen() {
        let coreDataService = CoreDataService()
        let historyViewModel = HistoryViewModel(output: self, coreDataService: coreDataService)
        let historyViewController = HistoryViewController(viewModel: historyViewModel)
        
        router.setViewControllers([historyViewController])
    }
}

extension HistoryCoordinator: HistoryOutput {
    func showOperationInfo(at index: Int) {
        let dataSource = OperationInfoDataSource()
        let operation = dataSource.operations[index]
        
        let viewController = OperationInfoViewController(operation: operation)
        viewController.hidesBottomBarWhenPushed = true
        
        router.push(viewController)
    }
}

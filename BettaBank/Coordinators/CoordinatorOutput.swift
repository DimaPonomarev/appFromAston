//
//  CoordinatorOutput.swift
//  BettaBank
//
//  Created by Sofia Norina on 31.01.2024.
//

import UIKit

protocol CoordinatorOutput {
    func showViewController(viewController: UIViewController, hidesBottomBar: Bool)
    func closeDemo()
}

extension CoordinatorOutput {
    func closeDemo() {
        //  TODO: в этом методе реализовывается закрытие демо режима 
    }
}

//
//  BaseCoordinator.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 13.11.2023.
//

class BaseCoordinator {
    let router: Router
    let coordinatorsFactory: CoordinatorsFactoryProtocol
    var childCoordinators = [BaseCoordinator]()
    
    init(coordinatorsFactory: CoordinatorsFactoryProtocol, router: Router) {
        self.router = router
        self.coordinatorsFactory = coordinatorsFactory
    }
    
    func addDependency(_ coordinator: BaseCoordinator) {
        for element in childCoordinators where element === coordinator {
            return
        }
        
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: BaseCoordinator) {
        childCoordinators.removeAll(where: { $0 === coordinator })
    }
}

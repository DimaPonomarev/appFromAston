//
//  Coordinator.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 25.12.2023.
//

typealias Coordinator = BaseCoordinator & CoordinatorProtocol

protocol CoordinatorProtocol: AnyObject {
    var onStart: (() -> Void)? { get set }
    var onFinish: (() -> Void)? { get set }
    
    func start()
    func finish()
}

extension CoordinatorProtocol {
    var onFinish: (() -> Void)? {
        get { return { } }
        
        set { }
    }
    
    func finish() { onFinish?() }
}

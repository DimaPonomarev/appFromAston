//
//  SceneDelegate.swift
//  MRN Coordinator
//
//  Created by Margarita Slesareva on 01.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private let coordinatorFactory: CoordinatorsFactory = CoordinatorsFactory()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController = UINavigationController()
        let appCoordinator = coordinatorFactory.makeAppCoordinator(rootNavigationController: navigationController)
        
        window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
      
        appCoordinator.start()
    }
}

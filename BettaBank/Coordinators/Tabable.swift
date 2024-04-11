//
//  Tabable.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 26.12.2023.
//

import UIKit

private enum Constants {
    static let iconSize: CGSize = .init(width: Size.middleM, height: Size.middleM)
}

typealias TabCoordinator = Tabable & Coordinator

protocol Tabable {
    func setTab(coordinator: Coordinator, model: TabBarItemModel)
}

extension Tabable {
    func setTab(coordinator: Coordinator, model: TabBarItemModel) {
        coordinator.onStart = { [weak coordinator] in
            let tabBarItem = self.prepareTab(with: model)

            coordinator?.router.setTabBarItem(tabBarItem)
        }
    }
    
    private func prepareTab(with model: TabBarItemModel) -> UITabBarItem {
        let inactiveIconImage = UIImage(resource: model.inactiveIcon).withRenderingMode(.alwaysOriginal)
        let activeIconImage = UIImage(resource: model.activeIcon).withRenderingMode(.alwaysOriginal)
        
        let resizedInactiveIcon = inactiveIconImage.preparingThumbnail(of: Constants.iconSize)
        let resizedActiveIcon = activeIconImage.preparingThumbnail(of: Constants.iconSize)
        
        let tabBarItem = UITabBarItem(
            title: model.title.localized(),
            image: resizedInactiveIcon,
            selectedImage: resizedActiveIcon
        )
        UIImage(resource: model.inactiveIcon).withTintColor(.blueButton)
        tabBarItem.setTitleTextAttributes([.font: Font.lightSmallL], for: .normal)
        tabBarItem.selectedImage = tabBarItem.selectedImage?.withTintColor(
            .tabBarActiveColor,
            renderingMode: .alwaysOriginal
        )
        
        return tabBarItem
    }
}

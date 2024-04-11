//
//  UIViewController +Extension.swift
//  BettaBank
//
//  Created by Egor Kruglov on 15.11.2023.
//

import UIKit

extension UIViewController {
    func getTitlesAndValuesStack(titles: [UILabel], values: [UILabel]) -> UIStackView {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = Size.smallL
        
        for (title, value) in zip(titles, values) {
            let horizontalStack = UIStackView(arrangedSubviews: [title, value])
            horizontalStack.axis = .horizontal
            horizontalStack.spacing = Size.smallL
            
            verticalStack.addArrangedSubview(horizontalStack)
        }
        
        return verticalStack
    }
    
    func setupBackNavigationButton(type: BackNavigation, completionHandler: (() -> Void)? = nil) {
        let image = UIImage.chevronLeft

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image,
            primaryAction: UIAction.init(
                handler: { [weak self] _ in
                    // TODO: перенести переход в координатор
                    switch type {
                    case .dismiss:
                        self?.dismiss(animated: true)
                    case .pop:
                        self?.navigationController?.popViewController(animated: true)
                    case .changeEmail:
                        completionHandler?()
                    }
                }
            )
        )
        navigationItem.leftBarButtonItem?.tintColor = .textFieldPlaceholder
    }
    
    enum BackNavigation {
        case dismiss
        case pop
        case changeEmail
    }
}

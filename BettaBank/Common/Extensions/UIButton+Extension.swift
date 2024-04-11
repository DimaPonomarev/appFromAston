//
//  Extension+UIButton.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 10.11.2023.
//

import UIKit

extension UIButton {
    func openDescriptionButton() {
        self.setImage(UIImage(resource: .closed), for: .normal)
        self.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    func closeDescriptionButton() {
        self.setImage(UIImage(resource: .shown), for: .normal)
        self.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}

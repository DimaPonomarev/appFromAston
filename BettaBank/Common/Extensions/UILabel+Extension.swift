//
//  Extension+UILabel.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 10.11.2023.
//

import UIKit

extension UILabel {
    
    func makeLabelForProfileScreen(title: String) {
        self.text = title
        self.font = Font.mediumMiddleM
        self.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        self.minimumScaleFactor = 0.5
        self.adjustsFontSizeToFitWidth = true
    }
}

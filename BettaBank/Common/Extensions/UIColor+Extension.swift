//
//  UIColor+Extension.swift
//  BettaBank
//
//  Created by Dmitry Gorbunow on 11/10/23.
//

import UIKit

extension UIColor {
    convenience init(hex: UInt, alpha: Double = 1) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

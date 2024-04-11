//
//  Color.swift
//  BettaBank
//
//  Created by Софья Норина on 16.11.2023.
//

import UIKit

// TODO: - убрать дублирование цветов
extension UIColor {
    
    static let wrongPasswordColor: UIColor = .init(hex: 0xF53C14)
    static let correctPasswordColor: UIColor = .init(hex: 0x131313)
    static let textColor: UIColor = .init(hex: 0x131313)
    static let notActiveTextColor: UIColor = .init(hex: 0x131313, alpha: 0.5)
    static let linkedTextColor: UIColor = .init(hex: 0x428BF9)
    static let shadowBackgroundColor: UIColor = .init(hex: 0xF1F1F1)

    static let yellowButtonColor: UIColor = .init(hex: 0xFEDA00)
    static let notActiveButtonColor: UIColor = .init(hex: 0x848484)
    static let activeSegmentControlElenent: UIColor = .init(hex: 0xFFFFFF)
    
    static let mainBackgroundColor: UIColor = .init(hex: 0xFEFEFE)
    static let itemBackgroundColor: UIColor = .init(hex: 0xF3F3F3)
    static let gradientBackgroundColor: UIColor = .init(hex: 0xC9C9C9, alpha: 0.05)
    static let greenLabelColor: UIColor = .init(hex: 0x4CAF50)
    
    static let tabBarActiveColor: UIColor = .init(hex: 0x3E89FF)
    static let tabBarInactiveColor: UIColor = .init(hex: 0x808080)
    static let topMenu: UIColor = .init(hex: 0x4D5F71)
    
    static let bankAddressViewColor = UIColor(red: 1, green: 0.992, blue: 0.906, alpha: 1).cgColor
    static let accountAndDepositPercent = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
    
    static let blueButton: UIColor = .init(hex: 0x005AFE)
    static let buttonBorder: UIColor = .init(hex: 0x757F8A)
    static let grayButton: UIColor = .init(hex: 0xE8E8E8)
    static let labelGreen: UIColor = .init(hex: 0x4CAF50)
    static let labelRed: UIColor = .init(hex: 0xF53C14)
    static let textField: UIColor = .init(hex: 0xF3F3F3)
    static let textFieldPlaceholder: UIColor = .init(hex: 0x131313, alpha: 0.5)
}

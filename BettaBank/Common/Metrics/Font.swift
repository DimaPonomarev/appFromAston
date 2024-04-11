//
//  Font.swift
//  BettaBank
//
//  Created by Софья Норина on 16.11.2023.
//

// TODO: - поменять названия и заменить цифры на Size.

import UIKit

enum Font {
    static let lightSmallL = UIFont.systemFont(ofSize: 12, weight: .light)
    
    static let boldSmallL: UIFont = UIFont.systemFont(ofSize: 12, weight: .bold)
    static let boldSmallXL: UIFont = UIFont.systemFont(ofSize: 16, weight: .bold)
    static let boldMiddleS: UIFont = UIFont.systemFont(ofSize: 18, weight: .bold)
    static let boldMiddleM: UIFont = UIFont.systemFont(ofSize: 24, weight: .bold)
    static let boldMiddleXL: UIFont = UIFont.systemFont(ofSize: 32, weight: .bold)
    static let boldLargeM: UIFont = UIFont.systemFont(ofSize: 40, weight: .bold)
    
    static let regularSmallL: UIFont = UIFont.systemFont(ofSize: 12, weight: .regular)
    static let regularSmallXL: UIFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    static let regularMiddleM: UIFont = UIFont.systemFont(ofSize: 24, weight: .regular)
    static let regularMiddleL: UIFont = UIFont.systemFont(ofSize: 28, weight: .regular)
    static let regularMiddleXL: UIFont = UIFont.systemFont(ofSize: 32, weight: .regular)
    static let mediumSmallXL: UIFont = UIFont.systemFont(ofSize: 16, weight: .medium)
    static let mediumMiddleM: UIFont = UIFont.systemFont(ofSize: 24, weight: .medium)
    
    static let monospacedRegularSmallXL: UIFont = UIFont.systemFont(ofSize: 16, weight: .regular)

}

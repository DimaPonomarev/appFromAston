//
//  PersonalAccauntCustomButton.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 29.11.2023.
//

import UIKit

class PersonalAccountCustomButton: UIButton {
    
    func setupButton(_ text: String, _ color: UIColor) {
        self.backgroundColor = .yellowButtonColor
        self.setTitle(text, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.layer.cornerRadius = Size.smallM
        self.clipsToBounds = true
    }
}

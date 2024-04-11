//
//  UITextField+Extension.swift
//  BettaBank
//
//  Created by Dzhami on 27.11.2023.
//
// Подсвечивание textFild красным при вводе неподходящего пароля
import UIKit

extension UITextField {
    
    func highlightAsError() {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1.0
    }
    
    func removeHighlight() {
        layer.borderColor = nil
        layer.borderWidth = 0.0
    }
    
    func underlined() {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width - Size.middleXL, height: 1)
        border.backgroundColor = UIColor.gray.cgColor
        self.borderStyle = .none 
        self.layer.addSublayer(border)
    }
}

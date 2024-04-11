//
//  CustomLineViewOnDemoProfilePage.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 10.11.2023.
//

import UIKit

class CustomLineView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let path = UIBezierPath()
        path.move(to: rect.origin)        
        UIColor.black.setStroke()
        path.stroke()
    }
}

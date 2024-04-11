//
//  Extension +UIView.swift
//  MRN_TEST
//
//  Created by Egor Kruglov on 07.11.2023.
//

import UIKit

extension UIView {
    func setGradientBackground(
        from startColor: UIColor?,
        to endColor: UIColor?,
        cornerRadius: CGFloat? = nil
    ) {
        let gradientLayer = CAGradientLayer()
        guard let startColor = startColor, let endColor = endColor else { return }
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = .init(x: 0.5, y: 1)
        gradientLayer.endPoint = .init(x: 0.5, y: 0)
        gradientLayer.frame = bounds
        if let cornerRadius = cornerRadius {
            gradientLayer.cornerRadius = cornerRadius
        }
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
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
}

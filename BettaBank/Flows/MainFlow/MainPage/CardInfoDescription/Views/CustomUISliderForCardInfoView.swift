//
//  CustomUISliderForCardInfoView.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 17.12.2023.
//

import UIKit

private enum Constants {
    static let switchBackgroundColor = UIColor(red: 1, green: 0.95, blue: 0.46, alpha: 1)
    static let maxValueForSlider: Float = 1
    static let minValueForSlider: Float = 0
}

final class CustomUISliderForCardInfoView: UISlider {
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newBounds = super.trackRect(forBounds: bounds)
        newBounds.size.height = Size.smallXL
        return newBounds
    }
    
    func setupSliderIf(isBlocked: Bool) {
        self.value = isBlocked
        ? Constants.maxValueForSlider
        : Constants.minValueForSlider
        
        if isBlocked {
            self.thumbTintColor = .yellowButtonColor
            self.tintColor = Constants.switchBackgroundColor
        } else {
            self.thumbTintColor = .systemGray2
            self.tintColor = Constants.switchBackgroundColor
        }
    }
}

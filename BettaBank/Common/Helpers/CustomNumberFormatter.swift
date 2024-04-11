//
//  NumberFormatter.swift
//  BettaBank
//
//  Created by Sofia Norina on 13.12.2023.
//

import UIKit

class CustomNumberFormatter {
    private var numberFormatter: NumberFormatter
    
    init() {
        self.numberFormatter = NumberFormatter()
    }
    
    func configureFormatter(number: Float, label: UILabel) {
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "RUB"
        numberFormatter.groupingSeparator = " "
        
        if let formattedCount = numberFormatter.string(from: NSNumber(value: number)) {
            label.text = formattedCount
        }
    }
}

//
//  CardDetailsViewModel.swift
//  BettaBank
//
//  Created by Vadim Blagodarny on 11.12.2023.
//

import Foundation
import UIKit

protocol CardDetailsViewModelProtocol: AnyObject {
    func pasteBoardCopySingle(text: String)
    func pasteBoardCopyComplete(descriptions: [CardDetailsItemsModel],
                                details: CardDetailsDataModel)
}

final class CardDetailsViewModel: CardDetailsViewModelProtocol {
    
    private let output: CardInfoOutput

    //  MARK: - Init
    
    init(output: CardInfoOutput) {
        self.output = output
    }
    
    // MARK: - delegate methods

    func pasteBoardCopySingle(text: String) {
        UIPasteboard.general.string = text
    }

    // TODO: оптимизировать метод
    func pasteBoardCopyComplete(descriptions: [CardDetailsItemsModel],
                                details: CardDetailsDataModel) {
        let completeOutput = """
\(descriptions[0].description): \(details.cardHolder)
\(descriptions[1].description): \(details.cardType)
\(descriptions[2].description): \(details.cardNumber)
\(descriptions[3].description): \(details.cardDate)
\(descriptions[4].description): \(details.cardCVC)
\(descriptions[5].description): \(details.cardCurrency)
"""
        UIPasteboard.general.string = completeOutput
    }
}

//
//  CardViewModel.swift
//  BettaBank
//
//  Created by Egor Kruglov on 16.11.2023.
//  Edited by Vadim Blagodarnyi on 15.12.2023.
//

import Foundation

private enum Constants {
    static let numberHiddenPart = "**** "
    static let numberSuffixLength = 4
}

protocol CardViewModelProtocol {
    var cardData: CardData { get }
}

class CardViewModel: CardViewModelProtocol {
    
    //  MARK: - External properties
    
    var cardData: CardData

    //  MARK: - Init
    
    init(cardData: CardData) {
        self.cardData = cardData
        let numberSuffix = String(cardData.number.suffix(Constants.numberSuffixLength))
        self.cardData.number = Constants.numberHiddenPart.appending(numberSuffix)
        self.cardData.balance += self.cardData.currency.shortDescriptor
    }
}

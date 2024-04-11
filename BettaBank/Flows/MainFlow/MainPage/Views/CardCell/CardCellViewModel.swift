//
//  CardCellViewModel.swift
//  BettaBank
//
//  Created by Egor Kruglov on 29.11.2023.
//

import Foundation

protocol CardCellViewModelProtocol {
    
    var cardData: CardData { get }
}

class CardCellViewModel: CardCellViewModelProtocol {
    
    let cardData: CardData
    
    required init(cardData: CardData) {
        self.cardData = cardData
    }
}

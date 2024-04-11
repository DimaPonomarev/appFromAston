//
//  CardModels.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 25.01.2024.
//

import Foundation

struct ChooseNewCardModel {
    let productName: String
    let purchaseFee: Double
    let currencyName: String
    let loyaltyProgram: String
    let productType: TypeOfCard
    
    enum TypeOfCard: String {
        case debit = "Дебетовая"
        case credit = "Кредитная"
    }
    
    struct BaseCardViewModel {
        let type: TypeOfCard
        let name: String
    }
}

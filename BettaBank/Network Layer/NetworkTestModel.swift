//
//  NetworkTestModel.swift
//  BettaBank
//
//  Created by Dzhami on 05.12.2023.
//

import Foundation

struct NetworkTestModel: Decodable {
    var AUTHORIZATION: String
}

struct ChooseNewCardNetworkModel: Decodable {

    let cardProducts: [CardModel]
    
    struct CardModel: Decodable {
        let id: String
        let productName: String
        let productType: CardType
        let loyaltyProgram: String
        let purchaseFee: Double
        let currencyName: String
    }
    
    enum CardType: String, Decodable {
        case debit = "DEBIT"
        case credit = "CREDIT"
    }
}

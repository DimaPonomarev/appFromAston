//
//  Currency.swift
//  BettaBank
//
//  Created by Egor Kruglov on 28.11.2023.
//

import Foundation

struct Currency {
    let name: String
    let buyCost: Double
    let sellCost: Double
    let roundedFlagImageName: String
    
    // TODO: в будщем убрать и использовать данные от сервера, перенести во viewModel
    static let demoCurrencies: [Currency] = [
        Currency(
            name: Currencies.usd.rawValue,
            buyCost: 103.00, sellCost: 106.00,
            roundedFlagImageName: Currencies.usd.roundedFlagImageName
        ),
        Currency(
            name: Currencies.eur.rawValue,
            buyCost: 96.00,
            sellCost: 98.70,
            roundedFlagImageName: Currencies.eur.roundedFlagImageName
        ),
        Currency(
            name: Currencies.byn.rawValue,
            buyCost: 30.10,
            sellCost: 30.30,
            roundedFlagImageName: Currencies.byn.roundedFlagImageName
        )
    ]
}

enum Currencies: String {
    case usd
    case eur
    case byn
    
    var fullName: String {
        switch self {
        case .usd:
            "Доллар США"
        case .eur:
            "Евро"
        case .byn:
            "Белорусский рубль"
        }
    }
    
    var roundedFlagImageName: String {
        switch self {
        case .usd:
            "usdRounded"
        case .eur:
            "eurRounded"
        case .byn:
            "bynRounded"
        }
    }
}

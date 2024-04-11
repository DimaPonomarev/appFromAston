//
//  CardData.swift
//  MRN_TEST
//
//  Created by Egor Kruglov on 03.11.2023.
//  Edited by Vadim Blagodarnyi on 15.12.2023.
//

import Foundation

struct CardData {
    var cardOption: CardOption
    var cardType: CardType
    var cardVendor: CardVendor
    var currency: CardCurrency
    var balance: String
    var name: String?
    var number: String
    var expirationDate: String
    var isBlocked: Bool = false
}

enum CardOption: String, CaseIterable {
    case silver
    case gold
    case platinum
    case creditSilver
    case creditGold
    
    var name: String {
        var name = "Smart "
        
        switch self {
        case .silver:
            name += "Silver"
        case .gold:
            name += "Gold"
        case .platinum:
            name += "Platinum"
        case .creditSilver:
            name += "Silver"
        case .creditGold:
            name += "Gold"
        }
        
        return name
    }
    
    var monthlyCost: String {
        switch self {
        case .silver:
            return "99 ₽"
        case .gold:
            return "500 ₽ / 5 $ / 5 €"
        case .platinum:
            return "1000 ₽ / 10 $ / 10 €"
        case .creditSilver:
            return "0 ₽"
        case .creditGold:
            return "0 ₽"
        }
    }
    
    var currency: String {
        switch self {
        case .silver:
            return CardCurrency.rub.rawValue
        case .gold, .platinum, .creditSilver, .creditGold:
            return "\(CardCurrency.rub.rawValue), \(CardCurrency.usd.rawValue), \(CardCurrency.eur.rawValue)"
        }
    }
    
    var cardLevel: String {
        switch self {
        case .silver:
            return CardLevel.silver.rawValue
        case .gold:
            return CardLevel.gold.rawValue
        case .platinum:
            return CardLevel.platinum.rawValue
        case .creditSilver:
            return CardLevel.silver.rawValue
        case .creditGold:
            return CardLevel.gold.rawValue
        }
    }
    
    var cardType: String {
        switch self {
        case .silver, .gold, .platinum:
            CardType.debit.name
        case .creditSilver, .creditGold:
            CardType.credit.name
        }
    }
    
    var availableVendors: [CardVendor] {
        switch self {
        case .silver, .creditSilver, .creditGold:
            return [CardVendor.mir]
        case .gold, .platinum:
            return CardVendor.allCases
        }
    }
    
    var cashback: String { "2%" }
    
    var cardPurchaseCost: String { String.Demo.cardPurchaseCostFree.localized() }
    
    var cardValidityPeriod: String { String.Demo.cardValidityPeriod.localized() }
    
    static func getSummary(cardOption: CardOption) -> String {
        var text = "Smart \(cardOption.rawValue)"
        let vendorsNames = cardOption.availableVendors
            .map { $0.rawValue }
        vendorsNames.forEach { vendorName in
            text.append(", \(vendorName)")
        }

        return text
    }
}

enum CardVendor: String, CaseIterable {
    case visa = "Visa"
    case mastercard = "MasterCard"
    case mir = "Мир"
}

enum CardLevel: String {
    case silver = "Silver"
    case gold = "Gold"
    case platinum = "Platinum"
}

enum CardCurrency: String, CaseIterable {
    case rub = "Рубль"
    case usd = "Доллар"
    case eur = "Евро"
    
    var shortDescriptor: String {
        switch self {
        case .rub:
            "₽"
        case .usd:
            "$"
        case .eur:
            "€"
        }
    }
}

enum CardType {
    case debit
    case credit
    
    var name: String {
        switch self {
        case .debit:
            return String.Demo.debit.localized()
        case .credit:
            return String.Demo.credit.localized()
        }
    }
}

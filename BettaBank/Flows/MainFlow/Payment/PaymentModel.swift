//
//  PaymentModel.swift
//  BettaBank
//
//  Created by Софья Норина on 29.11.2023.
//

enum PaymentButton {
    
    case transfer
    case bankPayment
    case servesPayment
    case autopay
    case loanPayment
    case another
}

struct PaymentModel {
    let paymentProduct: PaymentButton
    let paymentTitle: String
}

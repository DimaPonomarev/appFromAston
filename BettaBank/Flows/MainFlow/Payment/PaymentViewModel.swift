//
//  PaymentViewModel.swift
//  BettaBank
//
//  Created by Софья Норина on 28.11.2023.
//

import Foundation

protocol PaymentViewModelProtocol: AnyObject {
    var data: [PaymentModel] { get }
}

final class PaymentViewModel: PaymentViewModelProtocol {
    
    //  MARK: - External properties
    
    let data = [PaymentModel(paymentProduct: .transfer, paymentTitle: PaymentConstants.transferLabelString),
                PaymentModel(paymentProduct: .bankPayment, paymentTitle: PaymentConstants.bankPaymentLabelString),
                PaymentModel(paymentProduct: .servesPayment, paymentTitle: PaymentConstants.servisPayLabelString),
                PaymentModel(paymentProduct: .autopay, paymentTitle: PaymentConstants.autoPayLabelString),
                PaymentModel(paymentProduct: .loanPayment, paymentTitle: PaymentConstants.loanPayLabelString),
                PaymentModel(paymentProduct: .another, paymentTitle: PaymentConstants.anotherLabelString)]
    
}

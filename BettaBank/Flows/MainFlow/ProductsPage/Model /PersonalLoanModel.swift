//
//  ProductsModel.swift
//  BettaBank
//
//  Created by Софья Норина on 11.12.2023.
//

import Foundation

struct PersonalLoanModel {
    let productName: String
    let countLabel: Float
    let openLabel: String
    let percent: String
    let type: CreditListProductType
    let statusType: CreditListProductStatus
}

struct FullPersonalLoanModel {
    let creditSum: Float
    let creditTerm: Int
    let principalDebt: Float
    let interestDebt: Float
    let periodPayment: Float
    let creditDate: String
    let creditCloseDate: String
    let creditNextPayment: String
    let penalty: Int
}

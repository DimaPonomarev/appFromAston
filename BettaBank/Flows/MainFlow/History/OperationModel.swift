//
//  OperationModel.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 12.12.2023.
//

import Foundation

struct OperationModel {
    let userName: String
    let operationType: String
    let operationCount: Float
    let systemType: String
    let imageURL: String
    let operationTime: String
    let fullInfo: FullOperationInfoModel
}

struct FullOperationInfoModel {
    let userAccountNumber: String
    let senserAccountNumber: String
    let senderBank: String
}

//
//  OperationInfoDataSource.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 12.12.2023.
//

import Foundation

protocol OperationInfoDataSourceProtocol: AnyObject {
    var operations: [OperationModel] { get }
}

final class OperationInfoDataSource: OperationInfoDataSourceProtocol {
    
    //  MARK: - Data Variables
    
    var operations = [OperationModel]()
    
    init() {
        getOperations()
    }
    
    func getOperations() {
        
        operations = [OperationModel(userName: HistoryStringValue.firstCellUserName,
                                     operationType: HistoryStringValue.firstCellOperationType,
                                     operationCount: HistoryStringValue.firstCellCount,
                                     systemType: "",
                                     imageURL: "",
                                     operationTime: HistoryStringValue.firstCellOperationDate,
                                     fullInfo: FullOperationInfoModel(userAccountNumber: HistoryStringValue.firstCellUserAccount,
                                                                      senserAccountNumber: HistoryStringValue.firstCellSenderAccount,
                                                                      senderBank: HistoryStringValue.firstCellSenderBank)),
                      OperationModel(userName: HistoryStringValue.secondCellUserName,
                                     operationType: HistoryStringValue.secondCellOperationType,
                                     operationCount: HistoryStringValue.secondCellCount,
                                     systemType: "",
                                     imageURL: "",
                                     operationTime: HistoryStringValue.secondCellOperationDate,
                                     fullInfo: FullOperationInfoModel(userAccountNumber: HistoryStringValue.secondCellUserAccount,
                                                                      senserAccountNumber: HistoryStringValue.secondCellSenderAccount,
                                                                      senderBank: HistoryStringValue.secondCellSenderBank))
        ]
    }
}

//
//  HistoryViewModel.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 12.12.2023.
//

import Foundation

protocol HistoryViewModelProtocol: AnyObject {
    var historyData: OperationInfoDataSource { get }
    
    func cellTapped(at index: Int)
    func saveOperationModel(with operationModel: OperationModel)
    func getAllOperations() -> [OperationModel]
    func deleteAllOperations()
}

final class HistoryViewModel: HistoryViewModelProtocol {
    var historyData = OperationInfoDataSource()
    
    //  MARK: - External properties
    
    private let output: HistoryOutput
    private let coreDataService: CoreDataServiceProtocol
    //  MARK: - Init
    
    init(output: HistoryOutput, coreDataService: CoreDataServiceProtocol) {
        self.output = output
        self.coreDataService = coreDataService
    }
    
    func cellTapped(at index: Int) {
        output.showOperationInfo(at: index)
    }
    
    // MARK: - CoreDataService
    
    func saveOperationModel(with operationModel: OperationModel) {
        coreDataService.save { context in
            let operationManagedObject = OperationManagedObject(context: context)
            operationManagedObject.senderName = operationModel.userName
            operationManagedObject.operationType = operationModel.operationType
            operationManagedObject.operationCount = operationModel.operationCount
            operationManagedObject.systemType = operationModel.systemType
            operationManagedObject.imageURL = operationModel.imageURL
            operationManagedObject.operationTime = operationModel.operationTime
            operationManagedObject.userAccountNumber = operationModel.fullInfo.userAccountNumber
            operationManagedObject.senderAccountNumber = operationModel.fullInfo.senserAccountNumber
            operationManagedObject.senderBank = operationModel.fullInfo.senderBank
        }
    }
    
    func getAllOperations() -> [OperationModel] {
        do {
            let operationManagedObjects = try coreDataService.fetchOperations()
            let operationsModels: [OperationModel] = operationManagedObjects.compactMap { operationManagedObject in
                return OperationModel(userName: operationManagedObject.senderName ?? "",
                                      operationType: operationManagedObject.operationType ?? "",
                                      operationCount: operationManagedObject.operationCount,
                                      systemType: operationManagedObject.systemType ?? "",
                                      imageURL: operationManagedObject.imageURL ?? "",
                                      operationTime: operationManagedObject.operationTime ?? "",
                                      fullInfo: FullOperationInfoModel(
                                        userAccountNumber: operationManagedObject.userAccountNumber ?? "",
                                        senserAccountNumber: operationManagedObject.senderAccountNumber ?? "",
                                        senderBank: operationManagedObject.senderBank ?? ""))
            }
            return operationsModels
        } catch {
            print(error)
            return []
        }
    }
    
    func deleteAllOperations() {
        coreDataService.deleteAllOperations()
    }
}

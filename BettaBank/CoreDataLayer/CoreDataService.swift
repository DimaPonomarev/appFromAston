//
//  CoreDataService.swift
//  BettaBank
//
//  Created by Роман Козловский on 18.01.2024.
//

// MARK: - Import

import Foundation
import CoreData

// MARK: - CoreDataServiceProtocol

protocol CoreDataServiceProtocol: AnyObject {
    func fetchOperations() throws -> [OperationManagedObject]
    func save(block: (NSManagedObjectContext) throws -> Void)
    func deleteAllOperations()
}

final class CoreDataService {
    
    // MARK: - Private Properties
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "OperationDataModel")
        persistentContainer.loadPersistentStores { _, error in
            guard let error else { return }
            print(error)
        }
        return persistentContainer
    }()
    
    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}

// MARK: - CoreDataServiceProtocol Implementation
  
extension CoreDataService: CoreDataServiceProtocol {
    func fetchOperations() throws -> [OperationManagedObject] {
        let fetchRequest = OperationManagedObject.fetchRequest()
        return try viewContext.fetch(fetchRequest)
    }
    
    func save(block: (NSManagedObjectContext) throws -> Void) {
        let backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.performAndWait {
            do {
                try block(backgroundContext)
                if backgroundContext.hasChanges {
                    try backgroundContext.save()
                }
            } catch {
                print(error)
            }
        }
    }
    
    func deleteAllOperations() {
        do {
            let operationManagedObjects = try fetchOperations()
            operationManagedObjects.forEach { operationManagedObject in
                viewContext.delete(operationManagedObject)
            }
            try viewContext.save()
        } catch {
            print(error)
        }
    }
}

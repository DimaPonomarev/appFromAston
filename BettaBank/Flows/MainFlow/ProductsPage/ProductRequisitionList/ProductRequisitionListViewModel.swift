//
//  ProductRequisitionListViewModel.swift
//  BettaBank
//
//  Created by Vadim Blagodarny on 29.12.2023.
//

enum ProductRequisitionState: String {
    case approved = "Одобрено"
    case processing = "В обработке"
    case denied = "Отказано"
    case cancelled = "Отозвана"
}

enum ProductRequisitionType: Int, CaseIterable {
    case card
    case account
    case credit
    case deposit
    
    func getProductTypeName() -> String {
        switch self {
            
        case .card:
            "Карты"
        case .account:
            "Счета"
        case .credit:
            "Кредиты"
        case .deposit:
            "Депозиты"
        }
    }
}

struct ProductRequisitionModel {
    let name: String
    let description: String
    let state: ProductRequisitionState
    let type: ProductRequisitionType
    let amount: Int
    let interestRate: Int
    let loanTerm: Int
    let openingDate: String
}

protocol ProductRequisitionListViewModelProtocol: AnyObject {
    func getProductListFiltered(productType: ProductRequisitionType) -> [ProductRequisitionModel]
    func getProductTypes() -> [String]
    func getCurrentProductType() -> ProductRequisitionType
    func setCurrentProductType(index: Int)
    func showDetails(model: ProductRequisitionModel)
}

final class ProductRequisitionListViewModel: ProductRequisitionListViewModelProtocol {
    
    // MARK: - private variables
    
    private let productList: [ProductRequisitionModel]
    private var currentProductType: ProductRequisitionType = .credit
    private let factory: ProductModuleFactoryProtocol
    
    let output: CoordinatorOutput
    
    // MARK: - init
    
    init(productList: [ProductRequisitionModel], output: CoordinatorOutput, factory: ProductModuleFactoryProtocol) {
        self.productList = productList
        self.output = output
        self.factory = factory
        currentProductType = productList.last?.type ?? .credit
    }
    
    // MARK: - delegate methods
    
    func getProductListFiltered(productType: ProductRequisitionType) -> [ProductRequisitionModel] {
        return productList.compactMap { $0.type == productType ? $0 : nil }
    }
    
    func getProductTypes() -> [String] {
        var productTypes: [String] = []
        
        ProductRequisitionType.allCases.forEach { productType in
            productTypes.append(productType.getProductTypeName())
        }
        
        return productTypes
    }
    
    func getCurrentProductType() -> ProductRequisitionType {
        currentProductType
    }
    
    func setCurrentProductType(index: Int) {
        currentProductType = ProductRequisitionType.allCases[index]
    }
    
    func showDetails(model: ProductRequisitionModel) {
        let viewController = factory.makeViewController(type: .fullInfoReuisition)
        output.showViewController(viewController: viewController, hidesBottomBar: true)
    }
}

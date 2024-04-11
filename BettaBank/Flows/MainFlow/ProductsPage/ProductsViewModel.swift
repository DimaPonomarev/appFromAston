//
//  ProductsViewModel.swift
//  BettaBank
//
//  Created by Софья Норина on 9.11.2023.
//

import UIKit

enum CreditListProductStatus: String {
    case active = "Активен"
    case closed = "Закрыт"
    case blocked = "Заблокирован"
}

enum CreditListProductType: Int, CaseIterable {
    case loan
    case deposit
    case account
    
    func getProductTypeName() -> String {
        switch self {
            
        case .account:
            "Счета"
        case .loan:
            "Кредиты"
        case .deposit:
            "Депозиты"
        }
    }
}

protocol ProductsViewModelProtocol: AnyObject {
    var output: CoordinatorOutput { get }
    var loanData: [PersonalLoanModel]? { get }
    var loanfullInfo: [FullPersonalLoanModel]? { get }
    var depositData: [PersonalDepositModel]? { get }
    var accountData: [PersonalAccountModel] { get }
    func getProductTypes() -> [String]
    func setCurrentProductType(index: Int)
    func getProductListFiltered(productType: CreditListProductType) -> [PersonalLoanModel]
    func getCurrentProductType() -> CreditListProductType
    func cellDidTapped(indexPath: IndexPath)
    func showApplication()
    func getCurrentAccountModel(index: Int) -> PersonalAccountModel
    func getCountAccountModel() -> Int
}

final class ProductsViewModel: ProductsViewModelProtocol {
    
    //  MARK: - external properties
    
    private let factory: ProductModuleFactoryProtocol
    internal let output: CoordinatorOutput
    
    var accountData: [PersonalAccountModel] = [
        PersonalAccountModel(accountName: "Зарплатная", accountNumber: "1 2 3 * * * * * * * 2 3 4 1",
                               balance: 20510.00, status: .active, accountType: "Депозитный"),
        PersonalAccountModel(accountName: "Мой кредит", accountNumber: "1 2 3 * * * * * * * 2 3 4 1",
                               balance: 100002000, status: .active, accountType: "Депозитный"),
        PersonalAccountModel(accountName: "Мой кредит", accountNumber: "1 2 3 * * * * * * * 2 3 4 1",
                               balance: 102020202.03, status: .closed, accountType: "Кредитный")]
    
    var loanData: [PersonalLoanModel]? = []
    var loanfullInfo: [FullPersonalLoanModel]? = []
    
    var depositData: [PersonalDepositModel]?
    
    //  MARK: - private properties
    
    private var currentProductType: CreditListProductType = .loan
    
    //  MARK: - init
    
    init(output: CoordinatorOutput, factory: ProductModuleFactoryProtocol) {
        currentProductType = loanData?.last?.type ?? .loan
        self.output = output
        self.factory = factory
    }
    
    //  MARK: - external func
    
    func getProductTypes() -> [String] {
        var productTypes: [String] = []
        
        CreditListProductType.allCases.forEach { productType in
            productTypes.append(productType.getProductTypeName())
        }
        return productTypes
    }
    
    func setCurrentProductType(index: Int) {
        currentProductType = CreditListProductType.allCases[index]
    }
    
    func getCurrentProductType() -> CreditListProductType {
        currentProductType
    }
    func getCurrentAccountModel(index: Int) -> PersonalAccountModel {
        return accountData[index]
    }
    
    func getCountAccountModel() -> Int {
        accountData.count
    }
    
    func getProductListFiltered(productType: CreditListProductType) -> [PersonalLoanModel] {
        return loanData?.compactMap { $0.type == productType ? $0 : nil } ?? []
    }
    
    func cellDidTapped(indexPath: IndexPath) {
        let item = getProductListFiltered(productType: getCurrentProductType())[indexPath.row]
        guard let itemFullInfo = loanfullInfo?[indexPath.row] else { return }
        
        showFullProductInfo(item: item, fullInfo: itemFullInfo)
    }
}

extension ProductsViewModel {
    func showFullProductInfo(item: PersonalLoanModel, fullInfo: FullPersonalLoanModel) {
        let viewController = factory.makeViewController(type: .fullInfoProduct)
        output.showViewController(viewController: viewController, hidesBottomBar: true)
    }
    
    func showApplication() {
        let viewController = factory.makeViewController(type: .requisition(output))
        output.showViewController(viewController: viewController, hidesBottomBar: true)
    }
}

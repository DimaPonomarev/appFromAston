//
//  ProductModuleFabrica.swift
//  BettaBank
//
//  Created by Sofia Norina on 28.01.2024.
//

import UIKit

enum ProductViewControllerType {
    case products(CoordinatorOutput)
    case fullInfoProduct
    case requisition(CoordinatorOutput)
    case fullInfoReuisition
}

protocol ProductModuleFactoryProtocol {
    func makeViewController(type: ProductViewControllerType) -> UIViewController
}

final class ProductModuleFactory: ProductModuleFactoryProtocol {
    
    func makeViewController(type: ProductViewControllerType) -> UIViewController {
        switch type {
        case .products(let output):
            let viewModel = ProductsViewModel(output: output, factory: self)
            return ProductsViewController(viewModel: viewModel)
        case .fullInfoProduct:
            return CustomerLoansViewController()
        case .requisition(let output):
            let viewModel = ProductRequisitionListViewModel(productList: [ProductRequisitionModel(name: "Betta экспресс",
                                                                                                  description: "Потребительский кредит",
                                                                                                  state: .approved,
                                                                                                  type: .deposit,
                                                                                                  amount: 5000000,
                                                                                                  interestRate: 7,
                                                                                                  loanTerm: 36,
                                                                                                  openingDate: "17.12.2022")],
                                                            output: output,
                                                            factory: self)
            return ProductRequisitionListViewController(viewModel: viewModel)
        case .fullInfoReuisition:
            let viewModel = CreditRequisitionDetailsViewModel(productData: ProductRequisitionModel(name: "Betta экспресс",
                                                                                                   description: "Потребительский кредит",
                                                                                                   state: .approved,
                                                                                                   type: .deposit,
                                                                                                   amount: 5000000,
                                                                                                   interestRate: 7,
                                                                                                   loanTerm: 36,
                                                                                                   openingDate: "17.12.2022"))
            return CreditRequisitionDetailsViewController(viewModel: viewModel)
        }
    }
}

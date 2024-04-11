//
//  CreditRequisitionDetailsViewModel.swift
//  BettaBank
//
//  Created by Vadim Blagodarny on 12.01.2024.
//

import Foundation

protocol CreditRequisitionDetailsViewModelProtocol: AnyObject {
    var productData: ProductRequisitionModel { get }
}

final class CreditRequisitionDetailsViewModel: CreditRequisitionDetailsViewModelProtocol {
    
    // MARK: - data variables
    
    let productData: ProductRequisitionModel
    
    // MARK: - init
    
    init(productData: ProductRequisitionModel) {
        self.productData = productData
    }
}

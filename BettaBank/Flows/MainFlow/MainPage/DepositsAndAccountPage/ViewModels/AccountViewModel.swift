//
//  AccountViewModel.swift
//  BettaBank
//
//  Created by Dzhami on 18.12.2023.
//

import Foundation

protocol AccountViewModelProtocol: AnyObject {
    
    var model: AccountFullInfoModel { get set }
}

class AccountViewModel: AccountViewModelProtocol {
    
    //  MARK: - External properties
    
    var model: AccountFullInfoModel
    
    //  MARK: Data Variables
    
    // MARK: Private Variables
    
    //  MARK: - Init
    
    init(model: AccountFullInfoModel) {
        self.model = model
    }
    
    //  MARK: - Delegate methodes
    
    //  MARK: - Private Methods
}

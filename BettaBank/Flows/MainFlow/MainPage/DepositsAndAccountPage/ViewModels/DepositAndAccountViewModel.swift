//
//  DepositAndAccountViewModel.swift
//  BettaBank
//
//  Created by Sofia Norina on 12.12.2023.
//

import UIKit

protocol DepositAndAccountViewModelProtocol: AnyObject {
    var depositData: [DepositModel] { get }
    var accountData: [AccountModel] { get }
    func sendData(for indexPath: IndexPath)
}

class DepositAndAccountViewModel: DepositAndAccountViewModelProtocol {
    
    private let coordinator: MainPageOutput
    
    init(coordinator: MainPageOutput) {
        self.coordinator = coordinator
    }
    
    //  MARK: - External properties
    
    var depositData = [DepositModel(productName: DepositStringValue.relibalDepositViewLabel,
                                    productPercent: DepositStringValue.relibalDepositViewPercent,
                                    productDescription: DepositStringValue.relibalDepositViewdescription ),
                       DepositModel(productName: DepositStringValue.investDepositViewLabel,
                                    productPercent: DepositStringValue.investDepositViewPercent,
                                    productDescription: DepositStringValue.investDepositViewdescription)]
    
    var accountData = [AccountModel(productName: DepositStringValue.cumulativeAccountViewLabel,
                                    productPercent: DepositStringValue.cumulativeAccountViewPercent,
                                    productDescription: DepositStringValue.cumulativeAccountViewdescription),
                       AccountModel(productName: DepositStringValue.currentAccountViewLabel,
                                    productPercent: DepositStringValue.currentAccountViewPercent,
                                    productDescription: DepositStringValue.currentAccountViewdescription)]
    
    var depositFullData = [
        // моковые данные 
        DepositFullInfoModel(productName: "Надежный", productPercent: "15% годовых",
                             duration: "12 месяцев", sum: "До 300000",
                             percent: "Каждый месяц", refill: "Нет",
                             withdrawal: "Нет", capitalization: "Нет"),
        DepositFullInfoModel(productName: "Инвестиционный", productPercent: "17% годовых",
                             duration: "12 месяцев", sum: "До 300000",
                             percent: "Каждый месяц", refill: "Нет",
                             withdrawal: "Нет", capitalization: "Нет")]
    
    var accountFullData = [
        AccountFullInfoModel(productName: "Накопительный", 
                             productPercent: "13,5% годовых",
                             currency: "рубль", 
                             opening: "Бесплатно",
                             percent: "Каждый месяц", 
                             withdrawal: "В любое время",
                             minSum: "Без ограничений",
                             maxSum: "10000000р"),
        AccountFullInfoModel(productName: "Текущий", 
                             productPercent: "Валюта RUB",
                             currency: "рубль",
                             opening: "Бесплатно",
                             percent: "Каждый месяц",
                             withdrawal: "В любое время",
                             minSum: "Без ограничений",
                             maxSum: "10000000р")]
    
    func sendData(for indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            let model = depositFullData[indexPath.row]
            coordinator.goToDepositPage(with: model)
        case 1:
            let model = accountFullData[indexPath.row]
            coordinator.goToAccountPage(with: model)
        default:
            return
        }
    }
}

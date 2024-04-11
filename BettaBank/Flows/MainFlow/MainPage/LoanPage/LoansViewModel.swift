//
//  LoansViewModel.swift
//  BettaBank
//
//  Created by Софья Норина on 29.11.2023.
//

import UIKit

protocol LoansViewModelProtocol: AnyObject {
    var loanData: [LoanModel] { get }
    func sendData(for indexPath: IndexPath)
    
    func dismissLoan(viewController: UIViewController)
}

class LoansViewModel: LoansViewModelProtocol {
    
    private let output: LoanPageOutput
    
    init(output: LoanPageOutput) {
        self.output = output
    }
    
    //  MARK: - External properties
    
    // моковые данные, позже будут заменены на данные с сервера
    var loanData: [LoanModel] = [
        LoanModel(productName: "Betta экспресс", productPercent: "20% годовых", productDescription: "Быстрый кредит под любые нужды"),
        LoanModel(productName: "Betta потребительский", productPercent: "5% годовых", productDescription: "Потребительский кредит под любые нужды"),
        LoanModel(productName: "Betta автокредит", productPercent: "5% годовых", productDescription: "Автокредит для покупки машины вашей мечты"),
        LoanModel(productName: "Betta ипотека", productPercent: "7% годовых", productDescription: "Быстрый кредит под любые нужды")]
    
    var loanFullData = [
        LoanFullInfoModel(productName: "Betta экспресс", loanType: "Потребительский кредит", productPercent: "20% годовых", loanDescription: "Быстрый кредит под любые нужды", minSum: "30000р", maxSum: "5000000р", duration: "12 месяцев", earlyRepayment: "Да", guarantors: "Да", incomeSertificate: "Да", withdrawal: "Да", deposit: "Нет", calculationScheme: "Аннуитетный", lateFee: "10%"),
        LoanFullInfoModel(productName: "Betta потребительский", loanType: "Потребительский кредит", productPercent: "5 - 20% годовых", loanDescription: "Потребительский кредит", minSum: "30000р", maxSum: "5000000р", duration: "12 месяцев", earlyRepayment: "Да", guarantors: "Да", incomeSertificate: "Да", withdrawal: "Да", deposit: "Нет", calculationScheme: "Аннуитетный", lateFee: "10%"),
        LoanFullInfoModel(productName: "Betta автокредит", loanType: "Автокредит", productPercent: "5% годовых", loanDescription: "Автокредит для покупки машины вашей мечты", minSum: "30000р", maxSum: "5000000р", duration: "12 месяцев", earlyRepayment: "Да", guarantors: "Да", incomeSertificate: "Да", withdrawal: "Да", deposit: "Нет", calculationScheme: "Аннуитетный", lateFee: "10%"),
        LoanFullInfoModel(productName: "Betta ипотека", loanType: "Ипотечное кредитование", productPercent: "7% годовых", loanDescription: "Быстрый кредит под любые нужды", minSum: "30000р", maxSum: "5000000р", duration: "12 месяцев", earlyRepayment: "Да", guarantors: "Да", incomeSertificate: "Да", withdrawal: "Да", deposit: "Нет", calculationScheme: "Аннуитетный", lateFee: "10%")]
    
    func dismissLoan(viewController: UIViewController) {
        output.dismissLoan(viewController: viewController)
    }
    
    func sendData(for indexPath: IndexPath) {
        let model = loanFullData[indexPath.row]
        output.goToFullInfoLoanVC(with: model)
    }
}

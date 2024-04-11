//
//  MainPageViewModel.swift
//  BettaBank
//
//  Created by Egor Kruglov on 27.11.2023.
//

import Foundation

protocol MainPageViewModelProtocol: AnyObject {
    var cellsViewModels: [CardCellViewModelProtocol] { get }
    var data: [MainPageModel] { get }
    func goToProfileViewController()
    func goToNotifications()
    func getNumberOfItemsInCardsCollectionView() -> Int
    func getNumberOfRowsInLinksTableView() -> Int
    func getTitleForCellAt(_ indexPath: IndexPath) -> String
    
    func showCardInfoDescriptionPage(_ index: Int)
    func showCards()
    func showDepositAccontPage()
    func showLoanPage()
}

class MainPageViewModel: MainPageViewModelProtocol {
    
    //  MARK: - External properties
    
    private let output: MainPageOutput
    
    let data = [MainPageModel(product: .cards),
                MainPageModel(product: .depositAccount),
                MainPageModel(product: .loanPage)]
    
    // MARK: - data properties
    
    let cellsViewModels: [CardCellViewModelProtocol] = [
        CardCellViewModel(
            cardData: CardData(
                cardOption: .silver,
                cardType: .debit,
                cardVendor: .mir,
                currency: .rub,
                balance: "2543.43 ₽",
                name: "Smart Silver",
                number: "** 1234",
                expirationDate: "05/26"
            )
        ),
        CardCellViewModel(
            cardData: CardData(
                cardOption: .platinum,
                cardType: .debit,
                cardVendor: .mir,
                currency: .usd,
                balance: "7666.10 ₽",
                name: "Smart Platinum",
                number: "** 5678",
                expirationDate: "12/30"
            )
        )
    ]
   
    //  MARK: - Init
    
    init(output: MainPageOutput) {
        self.output = output
    }
    
    //  MARK: - Delegate methodes
    
    func goToProfileViewController() {
        output.goToProfileViewController()
    }
    
    func goToNotifications() {
        output.goToNotifications()
    }
    func showCardInfoDescriptionPage(_ index: Int) {
        let chosenCardModel = cellsViewModels[index].cardData
        output.goToCardInfoDescriptionPage(chosenCardModel)
    }
    func showCards() {
        output.goToChooseNewCard()
    }
    
    func showDepositAccontPage() {
        output.goToDepositAccontPage()
    }
    
    func showLoanPage() {
        output.goToLoanPage()
    }
    
    func getNumberOfItemsInCardsCollectionView() -> Int {
        cellsViewModels.count
    }
    
    func getNumberOfRowsInLinksTableView() -> Int {
        LinksTableViewStructure.allCases.count
    }
    func goToLoanPage() {
        output.goToLoanPage()
    }
    
    func getTitleForCellAt(_ indexPath: IndexPath) -> String {
        switch indexPath.row {
        case LinksTableViewStructure.cards.rawValue:
            return LinksTableViewStructure.cards.name
        case LinksTableViewStructure.depositsAndAccounts.rawValue:
            return LinksTableViewStructure.depositsAndAccounts.name
        case LinksTableViewStructure.loans.rawValue:
            return LinksTableViewStructure.loans.name
        default:
            return ""
        }
    }
}

enum CardCollectionViewStructure: Int, CaseIterable {
    case cards
}

enum LinksTableViewStructure: Int, CaseIterable {
    case cards
    case depositsAndAccounts
    case loans
    
    var name: String {
        switch self {
        case .cards:
            MainPageTextLabels.cards
        case .depositsAndAccounts:
            MainPageTextLabels.depositsAndAccounts
        case .loans:
            MainPageTextLabels.loans
        }
    }
}

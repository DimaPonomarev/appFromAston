//
//  CardInfoDescriptionViewModel.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 17.12.2023.
//

import UIKit

private enum Constants {
    // swiftlint:disable line_length
    static let cardProducts = "Карточный продукт"
    static let details = "Реквизиты"
    static let operationHistory = "История операций"
    static let blockCard = "Заблокировать карту"
    static let changePinCode = "Изменить ПИН-код"
    static let closeCard = "Закрыть карту"
    static let unblockCardTitle = "Вы действительно хотите разблокировать карту?"
    static let unblockCardMessage = "Все операции по карте будут разблокированы."
    static let unblockCardAction = "Разблокировать"
    static let blockCardTitle = "Вы действительно хотите заблокировать карту?"
    static let blockCardMessage = "Все операции по карте будут заблокированы. Комиссии будут продолжать взиматься в прежнем размере. \nПри блокировке карты существующие обязательства перед банком остаются. \nДля погашения платежа можно использовать перевод средств по номеру счета."
    static let blockCardAction = "Заблокировать"
    static let closeCardTitle = "Вы действительно хотите закрыть карту?"
    static let closeCardMessage = "Все операции по карте будут заблокированы. Карта будет иметь статус закрытая в течение 30 дней. В течение срока можно отозвать заявку в отделении банка. При закрытии карты существующие обязательства перед банком остаются. После окончания срока карта окончательно закроется."
    static let redColorText = "в отделении банка"
    static let closeCardAction = "Закрыть карту"

    // swiftlint:enable line_length
}

protocol ChosenCardInfoViewModelProtocol: AnyObject {
    func sendDataToCardView() -> CardData
    func getNumberOfRowsInTableView(_ segmentView: SegmentsInSegmentControl) -> Int
    func getTitleForCellAt(_ indexPath: Int, _ segmentView: SegmentsInSegmentControl) -> String
    func getIconForCellAt(_ indexPath: Int, _ segmentView: SegmentsInSegmentControl) -> ImageResource?
    func getActionAt(_ indexPath: Int, _ segmentView: SegmentsInSegmentControl) -> (() -> Void)
    func getIsBlockedInfo(_ indexPath: Int) -> Bool
    
    var showingAlertToBlockCard: ((_ title: String, _ message: String, _ actionText: String) -> Void)? { get set }
    var showingAlertToCloseCard: ((_ title: String, _ text: NSMutableAttributedString?, _ actionText: String) -> Void)? { get set }
    func changeBlockValue()
}

final class ChosenCardInfoViewModel: ChosenCardInfoViewModelProtocol {
    
    //  MARK: - External properties
    
    private let output: CardInfoOutput
    var showingAlertToBlockCard: ((_ title: String, _ message: String, _ actionText: String) -> Void)?
    var showingAlertToCloseCard: ((_ title: String, _ text: NSMutableAttributedString?, _ actionText: String) -> Void)?
    
    //  MARK: Data Variables
    
    private lazy var modelForInformationSegmentScreen: [ChosenCardInfoModel] = [
        ChosenCardInfoModel(text: Constants.cardProducts, icon: .rightArrow, action: self.showCardProducts),
        ChosenCardInfoModel(text: Constants.details, icon: .rightArrow, action: self.showDetails),
        ChosenCardInfoModel(text: Constants.operationHistory, icon: .rightArrow, action: self.showOperationHistory)]
    
    private lazy var modelForManagementSegmentScreen: [ChosenCardInfoModel] = [
        ChosenCardInfoModel(text: Constants.blockCard, action: self.showBlockCardAlert),
        ChosenCardInfoModel(text: Constants.changePinCode, icon: .rightArrow, action: self.showChangePassowrd),
        ChosenCardInfoModel(text: Constants.closeCard, icon: .closeColoredIcon, action: self.showCloseCardAlert)]
        
    private var cardData = CardData(cardOption: .gold,
                                    cardType: .debit,
                                    cardVendor: .mastercard,
                                    currency: .usd,
                                    balance: "100500",
                                    number: "1111 2222 3333 4444",
                                    expirationDate: "12/34",
                                    isBlocked: false)
    
    //  MARK: - Init
    
    init(output: CardInfoOutput) {
        self.output = output
    }
    
    //  MARK: - Delegate methodes
    
    func sendDataToCardView() -> CardData {
        cardData
    }
    
    func getNumberOfRowsInTableView(_ segmentView: SegmentsInSegmentControl) -> Int {
        switch segmentView {
        case .information:
            return modelForInformationSegmentScreen.count
        case .management:
            return modelForManagementSegmentScreen.count
        }
    }
    
    func getTitleForCellAt(_ indexPath: Int, _ segmentView: SegmentsInSegmentControl) -> String {
        switch segmentView {
        case .information:
            return modelForInformationSegmentScreen[indexPath].text
        case .management:
            return modelForManagementSegmentScreen[indexPath].text
        }
    }
    
    func getIconForCellAt(_ indexPath: Int, _ segmentView: SegmentsInSegmentControl) -> ImageResource? {
        switch segmentView {
        case .information:
            return modelForInformationSegmentScreen[indexPath].icon
        case .management:
            return modelForManagementSegmentScreen[indexPath].icon
        }
    }
    
    func getActionAt(_ indexPath: Int, _ segmentView: SegmentsInSegmentControl) -> (() -> Void) {
        switch segmentView {
        case .information:
            return modelForInformationSegmentScreen[indexPath].action
        case .management:
            return modelForManagementSegmentScreen[indexPath].action
        }
    }
    
    func getIsBlockedInfo(_ indexPath: Int) -> Bool {
        return cardData.isBlocked
    }
    
    func changeBlockValue() {
        cardData.isBlocked.toggle()
    }
    
    func showCardImageView() -> CardData {
        return cardData
    }
    
    //  MARK: - Private methodes
    
    private func showCardProducts() {
        //        TODO: - добавить переходи на экран "Карточный продукт"
    }
    
    private func showDetails() {
        output.goToCardDetailsPage()
    }
    
    private func showOperationHistory() {
        //        TODO: - добавить переходи на экран "История операций"
    }
    
    private func showChangePassowrd() {
        output.goToPinCodeSetupPage()
    }
    
    private func showBlockCardAlert() {
        if cardData.isBlocked {
            showingAlertToBlockCard?(Constants.unblockCardTitle, Constants.unblockCardMessage, Constants.unblockCardAction)
        } else {
            showingAlertToBlockCard?(Constants.blockCardTitle,
                                     Constants.blockCardMessage,
                                     Constants.blockCardAction)
        }
    }
    private func showCloseCardAlert() {        
        showingAlertToCloseCard?(Constants.closeCardTitle,
                                 makeTextWithAttributedString(Constants.closeCardMessage),
                                 Constants.closeCardAction)
    }
    
    private func makeTextWithAttributedString(_ fullText: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: fullText)
        if let range = fullText.range(of: Constants.redColorText) {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: nsRange)
            return attributedString
        }
        return attributedString
    }
}

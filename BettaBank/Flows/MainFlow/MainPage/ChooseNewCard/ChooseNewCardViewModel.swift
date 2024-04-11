//
//  ChooseNewCardViewModel.swift
//  BettaBank
//
//  Created by Egor Kruglov on 16.11.2023.
//

import Foundation
import Combine

protocol ChooseNewCardViewModelProtocol: AnyObject {
    func makeRequestToShowAvailableCards(index: Int?)
    var avaibleCardsToBuyPublisher: PassthroughSubject<[ChooseNewCardModel], Never> { get }
}

final class ChooseNewCardViewModel: ChooseNewCardViewModelProtocol {
    
    //  MARK: - External properties
    
    private let output: MainPageOutput?
    private let networkLayer: NetworkServiceProtocol?

    //  MARK: Data Variables
    
    var cancellables: Set<AnyCancellable> = []
    var avaibleCardsToBuyPublisher = PassthroughSubject<[ChooseNewCardModel], Never>()

    //  MARK: - Init
    
    init(output: MainPageOutput?, network: NetworkServiceProtocol) {
        self.output = output
        self.networkLayer = network
    }
    
    //  MARK: - Delegate methods
    
    func makeRequestToShowAvailableCards(index: Int?) {
        switch index {
        case 1:  responseToShowAvaibleCards(ChooseNewCardNetworkModel.CardType.credit)
        default: responseToShowAvaibleCards(ChooseNewCardNetworkModel.CardType.debit)
        }
    }

    //  MARK: - Private methods

    private func responseToShowAvaibleCards(_ endPoint: ChooseNewCardNetworkModel.CardType) {
        
        let cancellable = networkLayer?.makeRequest(request: "").sink(receiveCompletion: { completion in
            switch completion {
            case .finished: break
            case .failure(let error): print(error)
            }
        }, receiveValue: { [unowned self] (result: ChooseNewCardNetworkModel) in
            let array: [ChooseNewCardModel] = result.cardProducts
//            TODO: .filter является временным решением
//            при появлении и подключении бека необходимо просто удалить, так как будет отправляться отдельный запрос по конкретному типу карт.
                .filter({$0.productType == endPoint})
                .map { [unowned self] in
                    ChooseNewCardModel(productName: $0.productName,
                                       purchaseFee: $0.purchaseFee,
                                       currencyName: $0.currencyName,
                                       loyaltyProgram: $0.loyaltyProgram,
                                       productType: self.setTypeCardImage($0.productType))
                }
            self.avaibleCardsToBuyPublisher.send(array)
        })
        cancellable?.store(in: &cancellables)
    }
    
    private func setTypeCardImage(_ cardType: ChooseNewCardNetworkModel.CardType) -> ChooseNewCardModel.TypeOfCard {
        switch cardType {
        case .credit: return .credit
        case .debit: return .debit
        }
    }
}

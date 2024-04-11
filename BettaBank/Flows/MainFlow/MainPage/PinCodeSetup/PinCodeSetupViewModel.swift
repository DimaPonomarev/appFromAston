//
//  PinCodeSetupViewModel.swift
//  BettaBank
//
//  Created by Vadim Blagodarny on 20.12.2023.
//

protocol PinCodeSetupViewModelProtocol: AnyObject {
    var pinCodeValue: String { get set }
    func changePinCode()
}

final class PinCodeSetupViewModel: PinCodeSetupViewModelProtocol {
    
    // MARK: - external properties
    
    private let output: CardInfoOutput
    
    // MARK: - data Variables
    
    var pinCodeValue = String()
    
    // MARK: - init
    
    init(output: CardInfoOutput) {
        self.output = output
    }
    
    // MARK: - delegate methods
    
    func changePinCode() {
        output.showPinCodeChangedViewController()
    }
}

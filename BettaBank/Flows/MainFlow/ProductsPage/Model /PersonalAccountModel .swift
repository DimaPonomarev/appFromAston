//
//  PersonalAccountModel .swift
//  BettaBank
//
//  Created by Sofia Norina on 12.12.2023.
//

struct PersonalAccountModel {
    let accountName: String
    let accountNumber: String
    let balance: Float
    let status: Status
    let accountType: String
    
    enum Status: String {
        case active = "Открыт"
        case closed = "Заблокирован"
    }
}

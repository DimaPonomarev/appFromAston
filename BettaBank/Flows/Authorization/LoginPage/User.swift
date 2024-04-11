//
//  User.swift
//  BettaBank
//
//  Created by Борис Кравченко on 09.11.2023.
//

import Foundation

struct Item {
    let id: Int
    let name: String
}

struct User {
    let phoneNumber: String
    let documentNumber: String
    let email: String
    let password: String
}

let users: [User] = [
    User(phoneNumber: "+79991234567", documentNumber: "1234567890", email: "123@mail.ru", password: "abc123"),
    User(phoneNumber: "+79991111111", documentNumber: "1122333444", email: "user@mail.ru", password: "abc123")
]

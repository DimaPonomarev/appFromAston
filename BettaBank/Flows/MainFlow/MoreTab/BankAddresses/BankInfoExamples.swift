//
//  BankInfoExamples.swift
//  BettaBank
//
//  Created by Борис Кравченко on 07.12.2023.
//

import Foundation

struct BankInfoExamples {
    static let branch1 = BankBranchInfo(
        latitude: 59.935493,
        longitude: 30.327392,
        name: "Отделение №1",
        address: "г. Санкт-Петербург, Невский пр-кт, 123",
        workingHours: "Пн-Пт: 9:00 - 18:00",
        isOpenNow: true,
        learnMoreURL: URL(string: "https://example.com/branch1"),
        distance: "300 м"
    )

    static let branch2 = BankBranchInfo(
        latitude: 59.938185,
        longitude: 30.32808,
        name: "Отделение №2",
        address: "г. Санкт-Петербург, пр. Ветеранов, 56",
        workingHours: "Пн-Пт: 10:00 - 19:00",
        isOpenNow: true,
        learnMoreURL: URL(string: "https://example.com/branch2"),
        distance: "400 м"
    )

    static let atm1 = BankBranchInfo(
        latitude: 59.937376,
        longitude: 30.33621,
        name: "Банкомат №56",
        address: "г. Санкт-Петербург, ул. Московская, 87",
        workingHours: "Круглосуточно",
        isOpenNow: true,
        learnMoreURL: URL(string: "https://example.com/atm1"),
        distance: "500 м"
    )

    static let atm2 = BankBranchInfo(
        latitude: 59.934517,
        longitude: 30.335059,
        name: "Банкомат №123",
        address: "г. Санкт-Петербург, пр. Лиговский, 34",
        workingHours: "Круглосуточно",
        isOpenNow: true,
        learnMoreURL: URL(string: "https://example.com/atm2"),
        distance: "750 м"
    )
}

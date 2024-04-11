//
//  MainPageModel.swift
//  BettaBank
//
//  Created by Софья Норина on 6.12.2023.
//

enum MainPageModelPage {
    
    case loanPage
    case depositAccount
    case cards
}

struct MainPageModel {
    let product: MainPageModelPage
}

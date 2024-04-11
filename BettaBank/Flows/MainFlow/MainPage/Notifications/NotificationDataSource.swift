//
//  NotificationDataSource.swift
//  BettaBank
//
//  Created by Margarita Slesareva on 06.12.2023.
//

protocol NotificationDataSourceProtocol: AnyObject {
    var notifications: [NotificationModel] { get }
}

final class NotificationDataSource: NotificationDataSourceProtocol {
    
    //  MARK: - Data Variables
    
    var notifications = [NotificationModel]()
    
    init() {
        getNotifications()
    }
    
    private func getNotifications() {
        // TODO: в этот метод добавить получение уведомлений из NetworkService
        
        notifications = [
            NotificationModel(
                title: """
                Мы ждем только Вас! Суперкэшбек 20% за онлайн покупки картой уже сейчас! 
                Переходите по ссылке: www.bettabank.com
                """,
                date: "22.12.22   17:34"
            ),
            NotificationModel(title: "Кешбэк 20%, забирай bettabanc.com/e/1abg65", date: "14.12.22   16:04")
        ]
    }
}

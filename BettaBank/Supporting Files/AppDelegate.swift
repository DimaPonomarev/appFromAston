//
//  AppDelegate.swift
//  MRN Coordinator
//
//  Created by Margarita Slesareva on 01.11.2023.
//

import UIKit
import YandexMapsMobile
import KeychainSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let keychain = KeychainSwift()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Проверка наличия API-ключа в Keychain
        if let storedAPIKey = keychain.get("api_key") {
            // Установка API-ключа для Yandex Maps
            YMKMapKit.setApiKey(storedAPIKey)
            YMKMapKit.sharedInstance()
        } else {
            // Если API-ключа нет в Keychain, читаем из Config.plist
            if let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
               let dictionary = NSDictionary(contentsOfFile: path),
               let apiKey = dictionary["APIKey"] as? String {

                // Сохранение API-ключа в Keychain
                keychain.set(apiKey, forKey: "api_key")

                // Установка API-ключа для Yandex Maps
                YMKMapKit.setApiKey(apiKey)
                YMKMapKit.sharedInstance()
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

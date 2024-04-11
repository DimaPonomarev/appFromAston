//
//  String+Extension .swift
//  BettaBank
//
//  Created by Dmitry Gorbunow on 11/6/23.
//

import Foundation

extension String {
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}

// локализация интерфейса
extension String {
    func localized() -> String {
        NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
}

// TODO: - перенести в общие файлы Strings
extension String {
    enum Demo {
        
        static var mainPageTitle: String {
            NSLocalizedString("Главная", comment: "")
        }
        static var walletTitle: String {
            NSLocalizedString("Кошелек", comment: "")
        }
        static var orderNewCardButtonTitle: String {
            NSLocalizedString("Заказать карту", comment: "")
        }
        static var newPaymentTemplateButtonTitle: String {
            NSLocalizedString("Новый платеж", comment: "")
        }
        static var transfersTemplateButtonTitle: String {
            NSLocalizedString("Переводы", comment: "")
        }
        static var addTemplateTemplateButtonTitle: String {
            NSLocalizedString("Новый шаблон", comment: "")
        }
        static var cardholderName: String {
            NSLocalizedString("CARDHOLDER NAME", comment: "")
        }
        static var debit: String {
            NSLocalizedString("Дебетовая", comment: "")
        }
        static var credit: String {
            NSLocalizedString("Кредитная", comment: "")
        }
        static var cardPurchaseCostFree: String {
            NSLocalizedString("Бесплатно", comment: "")
        }
        static var cardValidityPeriod: String {
            NSLocalizedString("60 месяцев", comment: "")
        }
        static var showMoreButtonTitle: String {
            NSLocalizedString("Показать больше", comment: "")
        }
        static var chooseCardTitle: String {
            NSLocalizedString("Выберите карту", comment: "")
        }
        static var cashbackTitle: String {
            NSLocalizedString("Кешбэк", comment: "")
        }
        static var cardPurchaseCostTitle: String {
            NSLocalizedString("Стоимость покупки", comment: "")
        }
        static var cardValidityPeriodTitle: String {
            NSLocalizedString("Срок действия", comment: "")
        }
        static var issueCardTitle: String {
            NSLocalizedString("Оформить карту", comment: "")
        }
        static var exampleUserName: String {
            NSLocalizedString("Дмитрий", comment: "")
        }
        static var noActiveCards: String {
            NSLocalizedString("У вас нет активных карт", comment: "")
        }
        static var chooseCurrencyLabel: String {
            NSLocalizedString("Выберите валюту", comment: "")
        }
        static var rubleTitle: String {
            NSLocalizedString("Рубль", comment: "")
        }
        static var euroTitle: String {
            NSLocalizedString("Доллар", comment: "")
        }
        static var dollarTitle: String {
            NSLocalizedString("Евро", comment: "")
        }
        static var chooseCardVendorLabel: String {
            NSLocalizedString("Выберите платежную систему", comment: "")
        }
        static var issueCardViewControllerTitle: String {
            NSLocalizedString("Оформление дебетовой карты", comment: "")
        }
        static var next: String {
            NSLocalizedString("Далее", comment: "")
        }
        static var personalDataLabel: String {
            NSLocalizedString("Личные данные", comment: "")
        }
        static var titleLabelText: String {
            NSLocalizedString("Заполните заявку", comment: "")
        }
        static var fullNamePlaceholder: String {
            NSLocalizedString("ФИО", comment: "")
        }
        static var birthDatePlaceholder: String {
            NSLocalizedString("Дата рождения", comment: "")
        }
        static var passportPlaceholder: String {
            NSLocalizedString("Серия и номер паспорта", comment: "")
        }
        static var phoneNumberPlaceholder: String {
            NSLocalizedString("Номер телефона", comment: "")
        }
        static var emailPlaceholder: String {
            NSLocalizedString("E-mail", comment: "")
        }
        static var orderButtonText: String {
            NSLocalizedString("Оформить", comment: "")
        }
        static var orderAlertTitle: String {
            NSLocalizedString("Ваша заявка оформлена", comment: "")
        }
        static var orderAlertMessage: String {
            NSLocalizedString("В ближайшее время с Вами свяжется сотрудник банка для подтверждения информации", comment: "")
        }
        static var orderAlertClose: String {
            NSLocalizedString("Закрыть", comment: "")
        }
        static var loanOfferDescriptionViewControllerTitle: String {
            "Потребительский кредит"
        }
        static var personalAccaunt: String {
            NSLocalizedString("Личный кабинет", comment: "")
        }
        static var userName: String {
            NSLocalizedString("Имя Пользователя", comment: "")
        }
        static var passportData: String {
            NSLocalizedString("Паспортные данные", comment: "")
        }
        static var email: String {
            NSLocalizedString("Email", comment: "")
        }
        static var exampleOfEmail: String {
            NSLocalizedString("irina@mail.ru", comment: "")
        }
        static var phoneNumber: String {
            NSLocalizedString("Телефон", comment: "")
        }
        static var exampleOfPhoneNumber: String {
            NSLocalizedString("89628600296", comment: "")
        }
        static var changePassword: String {
            NSLocalizedString("Изменение пароля", comment: "")
        }
        static var setupNotifications: String {
            NSLocalizedString("Настройка уведомлений", comment: "")
        }
        static var buttonSave: String {
            NSLocalizedString("Сохранить", comment: "")
        }
    }
}

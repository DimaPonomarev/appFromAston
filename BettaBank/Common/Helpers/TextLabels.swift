//
//  TextLabels.swift
//  BettaBank
//
//  Created by Борис Кравченко on 09.11.2023.
//

import Foundation

// swiftlint:disable line_length
// swiftlint:disable type_body_length

// TODO: - разнести по локальным метрикам

struct TextLabels {
    struct LoginVC {
        static let bankNameText = "Бетта-Банк"
        
        static var welcomeText: String {
            return NSLocalizedString("Привет!\nВойдите в Бэтта-Банк", comment: "")
        }
        static var email: String {
            return NSLocalizedString("Email", comment: "")
        }
        static var password: String {
            return NSLocalizedString("Пароль", comment: "")
        }
        static var repeatPassword: String {
            return NSLocalizedString("Повторить пароль", comment: "")
        }
        static var forgotPassword: String {
            return NSLocalizedString("Забыли пароль?", comment: "")
        }
        static var next: String {
            return NSLocalizedString("Вперед", comment: "")
        }
        static var further: String {
            return NSLocalizedString("Далее", comment: "")
        }
        static var noAccount: String {
            return NSLocalizedString("У вас нет аккаунта?", comment: "")
        }
        static var haveAccount: String {
            return NSLocalizedString("У вас уже есть аккаунт?", comment: "")
        }
        static var register: String {
            return NSLocalizedString("Зарегистрируйтесь", comment: "")
        }
        static var registration: String {
            return NSLocalizedString("Регистрация", comment: "")
        }
        static var login: String {
            return NSLocalizedString("Авторизуйтесь", comment: "")
        }
        static var phone: String {
            return NSLocalizedString("Телефон", comment: "")
        }
        static var phoneNumber: String {
            return NSLocalizedString("Номер телефона", comment: "")
        }
        static var documentNumber: String {
            return NSLocalizedString("Номер документа", comment: "")
        }
        static var document: String {
            return NSLocalizedString("Документ", comment: "")
        }
        static var documentData: String {
            return NSLocalizedString("Серия и номер паспорта", comment: "")
        }
        static var emailError: String {
            return NSLocalizedString("Введен некорректный Email", comment: "")
        }
        static var documentError: String {
            return NSLocalizedString("Номер документа должен содержать 10 цифр", comment: "")
        }
        static var phoneError: String {
            return NSLocalizedString("Номер телефона должен содержать 11 цифр", comment: "")
        }
        static var passwordError: String {
            return NSLocalizedString("Пароль должен содержать от 6 до 20 символов", comment: "")
        }
        static var wrongPassword: String {
            return NSLocalizedString("Неверный пароль", comment: "")
        }
        static var wrongEmail: String {
            return NSLocalizedString("Такой Email не зарегистрирован в системе", comment: "")
        }
        static var wrongPhone: String {
            return NSLocalizedString("Данный пользователь не найден", comment: "")
        }
        static var autorizationSuccess: String {
            return NSLocalizedString("Успешная авторизация. Переход в личный кабинет...", comment: "")
        }
        static var enterPhoneNumber: String {
            return NSLocalizedString("Введите номер телефона", comment: "")
        }
        static var enterDocumentNumber: String {
            return NSLocalizedString("Введите номер документа", comment: "")
        }
        static var enterEmail: String {
            return NSLocalizedString("Введите электронную почту", comment: "")
        }
        static var passwordRecovery: String {
            return NSLocalizedString("Восстановление пароля", comment: "")
        }
        static var changePassword: String {
            return NSLocalizedString("Сменить пароль", comment: "")
        }
        
        static var terms: String {
            return NSLocalizedString("Нажав кнопку «Далее», вы соглашаетесь с Правилами пользования СДБО и Политикой конфиденциальности и даёте согласие на сбор, обработку и Хранение ваших персональных данных", comment: "")
        }
        static var termsOfUse: String {
            return NSLocalizedString("Правилами пользования СДБО", comment: "")
        }
        static var privacyPolicy: String {
            return NSLocalizedString("Политикой конфиденциальности", comment: "")
        }
        static var dataStorage: String {
            return NSLocalizedString("Хранение ваших персональных данных", comment: "")
        }
        static var enterCodeFromSms: String {
            return NSLocalizedString("Введите код из смс", comment: "")
        }
        static var codeHasBeenSent: String {
            return NSLocalizedString("На Ваш номер телефона отправлен 6-значный код подтверждения", comment: "")
        }
        static var resendSMS: String {
            return NSLocalizedString("Отправить смс еще раз", comment: "")
        }
        static var createPassword: String {
            return NSLocalizedString("Придумайте пароль", comment: "")
        }
        static var  numberOfCharacters: String {
            return NSLocalizedString(" Количество символов от 6 до 20", comment: "")
        }
        static var  lowercaseAndUppercase: String {
            return NSLocalizedString(" Есть строчные и заглавные буквы", comment: "")
        }
        static var haveNumbers: String {
            return NSLocalizedString(" Есть цифры", comment: "")
        }
        static var haveSpecialCharacters: String {
            return NSLocalizedString(" Есть специальные символы !@#$%^&*()_-={}[]|;:'\",<.>/?", comment: "")
        }
    }
    
    struct ChangingAppPassword {
            static var numberOfCharacters: String {
                return NSLocalizedString(" Пароль должен состоять из 4 символов", comment: "")
            }
            static var haveNumbers: String {
                return NSLocalizedString(" Допускаются только цифры", comment: "")
            }
            static var incorrectOldPin: String {
                return NSLocalizedString("Некорректный старый пин-код. Попробуйте ещё раз", comment: "")
            }
            static var passwordsDontMatch: String {
                return NSLocalizedString("Пароли не совпадают", comment: "")
            }
            static var changeAppPasswordButtonText: String {
                return NSLocalizedString("Изменить", comment: "")
            }
            static var titleOfVC: String {
                return NSLocalizedString("Изменение пароля", comment: "")
            }
            static var toMain: String {
                return NSLocalizedString("На главную", comment: "")
            }
            static var passwordWasChangedSuccessfully: String {
                return NSLocalizedString("Пароль успешно изменён", comment: "")
            }
        }
    
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
        static var plastic: String {
            NSLocalizedString("Пластиковая", comment: "")
        }
        static var virtual: String {
            NSLocalizedString("Виртуальная", comment: "")
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
        static var monthlyCostTitle: String {
            NSLocalizedString("Ежемесячная стоимость обслуживания карты", comment: "")
        }
        static var currencylTitle: String {
            NSLocalizedString("Валюта", comment: "")
        }
        static var cardLeveltitle: String {
            NSLocalizedString("Уровень карты", comment: "")
        }
        static var cardTypeTitle: String {
            NSLocalizedString("Тип карты", comment: "")
        }
        static var chooseCardTitle: String {
            NSLocalizedString("Выберите карту", comment: "")
        }
        static var cashbackTitle: String {
            NSLocalizedString("Кешбэк", comment: "")
        }
        static var cardPurchaseCostTitle: String {
            NSLocalizedString("Стоимость покупки карты", comment: "")
        }
        static var cardValidityPeriodTitle: String {
            NSLocalizedString("Срок действия карты", comment: "")
        }
        static var issueCardTitle: String {
            NSLocalizedString("Оформить карту", comment: "")
        }
        static var userName: String {
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
        static var notifications: String {
            NSLocalizedString("Уведомления", comment: "")
        }
        static var smsNotifications: String {
            NSLocalizedString("SMS - Уведомления", comment: "")
        }
        static var pushNotifications: String {
            NSLocalizedString("Push - Уведомления", comment: "")
        }
        static var emailMailing: String {
            NSLocalizedString("E-mail-рассылка", comment: "")
        }
        static var enterEmail: String {
            NSLocalizedString("Укажите e-mail", comment: "")
        }
        static var wrongEmail: String {
            NSLocalizedString("Неверный формат e-mail", comment: "")
        }
    }
    
    enum Alert {
        static var backToSettings: String {
            NSLocalizedString("Вернуться в меню уведомлений?", comment: "")
        }
        static var unsavedChangesConfirmationMessage: String {
            NSLocalizedString("Изменения не будут сохранены.\nПродолжить?", comment: "")
        }
        static var cancelAction: String {
            NSLocalizedString("Отмена", comment: "")
        }
        static var continueAction: String {
            NSLocalizedString("Продолжить", comment: "")
        }
    }
}
// swiftlint:enable line_length
// swiftlint:enable type_body_length

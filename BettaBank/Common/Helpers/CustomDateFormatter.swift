//
//  CustomeDateForrmater.swift
//  BettaBank
//
//  Created by Sofia Norina on 15.12.2023.
//

import Foundation
import UIKit
import os.log

private enum CustomDateFormatterValue {
    static let errorMassage = "Ошибка при форматировании строки даты"
    static let subsystem = "BettaBank.Common.Helpers.CustomDateFormatter"
    static let category = "DateConversion"
}

enum CustomDateForrmater: String {
    case original = "yyyy-MM-dd'T'HH:mm:ssZ"
    case fullDate = "dd.MM.yyyy HH:mm"
    case onlyTime = "HH:mm"
    case onlyDate = "dd.MM.yyyy"
}

final class CustomDateFormatter {
    
    private let logger = Logger(subsystem: CustomDateFormatterValue.subsystem, category: CustomDateFormatterValue.category)

    func convertDateStringToTime(originalDateString: String, originalFormat: String, targetFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = originalFormat
        
        if let date = dateFormatter.date(from: originalDateString) {
            dateFormatter.dateFormat = targetFormat
            let formattedTime = dateFormatter.string(from: date)
            return formattedTime
        } else {
            logger.error("Failed to convert date string: \(originalDateString) with format \(originalFormat)")
            return nil
        }
    }
}

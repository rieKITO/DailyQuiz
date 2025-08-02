//
//  DateFormatterHelper.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 02.08.2025.
//

import Foundation

final class DateFormatterHelper {
    
    static func formatToDayMonthString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM"
        return formatter.string(from: date)
    }
    
    static func formatTime(date: Date?) -> String {
        guard let date = date else { return "--:--" }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
}

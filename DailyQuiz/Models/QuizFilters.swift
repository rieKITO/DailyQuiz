//
//  QuizFilters.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 03.08.2025.
//

import Foundation

struct QuizFilters {
    var category: Int? = nil
    var difficulty: String? = nil
}

enum QuizCategory: Int, CaseIterable, Identifiable {
    case generalKnowledge = 9
    case books = 10
    case film = 11
    case music = 12
    case science = 17
    case sports = 21

    var id: Int { rawValue }

    var displayName: String {
        switch self {
        case .generalKnowledge: return "Общие знания"
        case .books: return "Книги"
        case .film: return "Фильмы"
        case .music: return "Музыка"
        case .science: return "Наука"
        case .sports: return "Спорт"
        }
    }
}

enum QuizDifficulty: String, CaseIterable, Identifiable {
    case easy, medium, hard

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .easy: return "Легкая"
        case .medium: return "Средняя"
        case .hard: return "Сложная"
        }
    }
}

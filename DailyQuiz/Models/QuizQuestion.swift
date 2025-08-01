//
//  Question.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 01.08.2025.
//

import Foundation

struct QuizResponse: Codable {
    let responseCode: Int
    let results: [QuizQuestion]

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}

struct QuizQuestion: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case type
        case difficulty
        case category
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}

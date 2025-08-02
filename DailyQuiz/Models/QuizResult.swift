//
//  QuizResult.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 02.08.2025.
//

import Foundation

struct QuizResult: Identifiable {
    let id = UUID()
    let date: Date
    let answeredQuestions: [AnsweredQuestion]
    
    var correctAnswersCount: Int {
        answeredQuestions.filter({ $0.answerIsCorrect }).count
    }
    
    var answeredQuestionsCount: Int {
        answeredQuestions.count
    }
}

struct AnsweredQuestion: Identifiable {
    let id = UUID()
    let questionText: String
    let selectedAnswer: String?
    let correctAnswer: String
    
    var answerIsCorrect: Bool {
        selectedAnswer == correctAnswer
    }
}

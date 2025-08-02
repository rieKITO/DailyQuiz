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
    
    var resultDescription: QuizResultDescription {
        QuizResultDescription(correctAnswersCount: correctAnswersCount)
    }
}

struct AnsweredQuestion: Identifiable {
    let id = UUID()
    let questionText: String
    let allAnswers: [String]
    let selectedAnswer: String?
    let correctAnswer: String
    
    var answerIsCorrect: Bool {
        selectedAnswer == correctAnswer
    }
}

enum QuizResultDescription: Int {
    case terrible = 0
    case low = 1
    case medium = 2
    case good = 3
    case great = 4
    case perfect = 5
    
    init(correctAnswersCount: Int) {
        switch correctAnswersCount {
        case 0: self = .terrible
        case 1: self = .low
        case 2: self = .medium
        case 3: self = .good
        case 4: self = .great
        case 5: self = .perfect
        default: self = .perfect
        }
    }
    
    var title: String {
        switch self {
        case .terrible: return "Бывает и так!"
        case .low: return "Сложный вопрос?"
        case .medium: return "Есть над чем поработать"
        case .good: return "Хороший результат!"
        case .great: return "Почти идеально!"
        case .perfect: return "Идеально!"
        }
    }
    
    var subtitle: String {
        switch self {
        case .terrible: return "0/5 — не отчаивайтесь. Начните заново и удивите себя!"
        case .low: return "1/5 — иногда просто не ваш день. Следующая попытка будет лучше!"
        case .medium: return "2/5 — не расстраивайтесь, попробуйте ещё раз!"
        case .good: return "3/5 — вы на верном пути. Продолжайте тренироваться!"
        case .great: return "4/5 — очень близко к совершенству. Ещё один шаг!"
        case .perfect: return "5/5 — вы ответили на всё правильно. Это блестящий результат!"
        }
    }
}

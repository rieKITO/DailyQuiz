//
//  DeveloperPreview.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 01.08.2025.
//

import Foundation

final class DeveloperPreview {
    
    static let shared = DeveloperPreview()
    
    let quizViewModel = QuizViewModel()
    
    private init() {
        addQuestionInViewModel()
    }
    
    func addQuestionInViewModel() {
        quizViewModel.quizQuestions.append(question)
    }
    
    let question: QuizQuestion = QuizQuestion(
        type: "multiple",
        difficulty: "easy",
        category: "General Knowledge",
        question: "In the video-game franchise Kingdom Hearts, the main protagonist, carries a weapon with what shape?",
        correctAnswer: "Key",
        incorrectAnswers: [
            "Sword",
            "Pen",
            "Cellphone"
        ]
    )
    
}

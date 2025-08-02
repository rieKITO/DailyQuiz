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
    
    let historyViewModel = QuizHistoryViewModel()
    
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
    
    let quizResult: QuizResult = QuizResult(
        date: Date(),
        answeredQuestions: [
            AnsweredQuestion(
                questionText: "In the video-game franchise Kingdom Hearts, the main protagonist, carries a weapon with what shape?",
                allAnswers: ["1", "Key", "3", "4"],
                selectedAnswer: "Key",
                correctAnswer: "Key"
            ),
            AnsweredQuestion(
                questionText: "Correct answer is 3",
                allAnswers: ["1", "2", "3", "4"],
                selectedAnswer: "2",
                correctAnswer: "3"
            ),
            AnsweredQuestion(
                questionText: "Correct answer is 1",
                allAnswers: ["1", "2", "3", "4"],
                selectedAnswer: "1",
                correctAnswer: "1"
            ),
            AnsweredQuestion(
                questionText: "Correct answer is 3",
                allAnswers: ["1", "2", "3", "4"],
                selectedAnswer: "3",
                correctAnswer: "3"
            ),
            AnsweredQuestion(
                questionText: "Correct answer is 1",
                allAnswers: ["1", "2", "3", "4"],
                selectedAnswer: "4",
                correctAnswer: "1"
            )
        ]
    )
    
}

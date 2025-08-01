//
//  QuizViewModel.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 01.08.2025.
//

import Foundation
import Combine

final class QuizViewModel: ObservableObject {
    
    // MARK: - Published
    
    @Published
    var quizQuestions: [QuizQuestion] = []
    
    @Published
    var currentQuestionIndex: Int = 0
    
    @Published
    var selectedAnswer: String? = nil
    
    // MARK: - Services
    
    private let quizDataService = QuizDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init() {
        addSubscribers()
    }
    
    // MARK: - Subscribers
    
    private func addSubscribers() {
        quizDataService.$quizQuestions
            .sink { [weak self] returnedQuizQuestions in
                self?.quizQuestions = returnedQuizQuestions
            }
            .store(in: &cancellables)
    }
    
}

// MARK: - Questions And Answers Methods

extension QuizViewModel {
    
    func goToNextQuestion() {
        selectedAnswer = nil
        if currentQuestionIndex < quizQuestions.count - 1 {
            currentQuestionIndex += 1
        } else {
            currentQuestionIndex = 0
        }
    }
    
}

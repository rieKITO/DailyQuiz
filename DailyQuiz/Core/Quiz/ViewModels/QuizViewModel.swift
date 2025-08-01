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

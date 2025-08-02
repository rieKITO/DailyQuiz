//
//  QuizHistoryViewModel.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 02.08.2025.
//

import Foundation
import Combine

final class QuizHistoryViewModel: ObservableObject {
    
    // MARK: - Published
    
    @Published var quizHistory: [QuizResult] = []
    
    // MARK: - Services
    
    private let dataService = QuizHistoryDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init() {
        addSubscribers()
    }
    
    // MARK: - Private Methods
    
    private func addSubscribers() {
        dataService.$allQuizHistory
            .receive(on: DispatchQueue.main)
            .assign(to: \.quizHistory, on: self)
            .store(in: &cancellables)
    }
    
}

// MARK: - CoreData Methods

extension QuizHistoryViewModel {
    
    // Public Methods
    
    func saveResult(result: QuizResult) {
        dataService.saveQuizResult(result: result)
    }
    
    func deleteResult(result: QuizResult) {
        dataService.deleteQuizResult(result: result)
    }
    
}

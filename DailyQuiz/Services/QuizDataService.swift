//
//  QuizDataService.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 01.08.2025.
//

import Foundation
import Combine

final class QuizDataService {
    
    // MARK: - Published
    
    @Published
    var quizQuestions: [QuizQuestion] = []
    
    // MARK: - Private Properties
    
    private var quizDataSubscription: AnyCancellable?
    
    // MARK: - Init
    
    init() {
        getQuizData()
    }
    
    // MARK: - Public Methods
    
    func getQuizData() {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=5&type=multiple&category=9&difficulty=easy") else { return }
        quizDataSubscription = NetworkingManager.download(url: url)
            .decode(type: QuizResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] returnedQuizResponse in
                    self?.quizQuestions = returnedQuizResponse.results
                    self?.quizDataSubscription?.cancel()
                })
    }
    
}

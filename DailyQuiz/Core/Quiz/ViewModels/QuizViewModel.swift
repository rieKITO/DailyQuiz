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
    
    @Published
    var isLoading: Bool = false
    
    @Published
    var quizIsFinished: Bool = false
    
    @Published
    var lastResult: QuizResult? = nil
    
    // MARK: - Private Properties
    
    private var answeredQuestions: [AnsweredQuestion] = []
    
    // MARK: - Services
    
    private let quizDataService = QuizDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init() {}
    
    // MARK: - Private Methods
    
    private func addSubscribers() {
        quizDataService.$quizQuestions
            .sink { [weak self] returnedQuizQuestions in
                self?.quizQuestions = returnedQuizQuestions
                DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                    self?.isLoading = false
                }
            }
            .store(in: &cancellables)
    }
    
}

// MARK: - Questions And Answers Methods

extension QuizViewModel {
    
    // Public Methods
    
    func loadQuizQuestions() {
        isLoading = true
        quizDataService.getQuizData()
        addSubscribers()
    }
    
    func goToNextQuestion() {
        saveAnswer()
        self.selectedAnswer = nil
        
        if currentQuestionIndex < quizQuestions.count - 1 {
            quizIsFinished = false
            currentQuestionIndex += 1
        } else {
            quizIsFinished = true
            currentQuestionIndex = 0
            lastResult = QuizResult(date: Date(), answeredQuestions: answeredQuestions)
            answeredQuestions = []
        }
    }
    
    func restart() {
        quizIsFinished = false
        quizQuestions = []
    }
    
    // Private Methods
    
    private func saveAnswer() {
        guard
            let selectedAnswer = selectedAnswer,
            currentQuestionIndex < quizQuestions.count
        else { return }
        
        let question = quizQuestions[currentQuestionIndex]
        let answeredQuestion = AnsweredQuestion(
            questionText: question.question,
            allAnswers: question.incorrectAnswers + [question.correctAnswer],
            selectedAnswer: selectedAnswer,
            correctAnswer: question.correctAnswer
        )
        
        answeredQuestions.append(answeredQuestion)
    }
    
}

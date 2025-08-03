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
    var currentQuizQuestionsShuffledAnswers: [[String]]? = []
    
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
    
    @Published
    var resultAnswerShown: Bool = false
    
    @Published
    var filters = QuizFilters()
    
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
                self?.currentQuizQuestionsShuffledAnswers = self?.quizQuestions.map { question in
                    (question.incorrectAnswers + [question.correctAnswer]).shuffled()
                } ?? []
                DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                    DispatchQueue.main.async {
                        self?.isLoading = false
                    }
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
        quizDataService.getQuizData(filters: filters)
        addSubscribers()
    }
    
    func goToNextQuestion() {
        saveAnswer()
        selectedAnswer = nil
        
        if currentQuestionIndex < quizQuestions.count - 1 {
            currentQuestionIndex += 1
        } else {
            finishQuiz(shouldSaveResult: true)
        }
    }
    
    func restart() {
        quizIsFinished = false
        currentQuestionIndex = 0
        selectedAnswer = nil
        answeredQuestions = []
        lastResult = nil
        quizQuestions = []
        filters.category = nil
        filters.difficulty = nil
    }
    
    func finishQuiz(shouldSaveResult: Bool) {
        quizIsFinished = true
        
        if shouldSaveResult {
            lastResult = QuizResult(
                id: UUID(),
                date: Date(),
                answeredQuestions: answeredQuestions
            )
        } else {
            lastResult = nil
        }

        currentQuestionIndex = 0
        answeredQuestions = []
        selectedAnswer = nil
    }
    
    // Answer Highlighting
    
    func showAnswerResult() {
        self.resultAnswerShown = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.resultAnswerShown = false
            self.goToNextQuestion()
        }
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

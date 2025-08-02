//
//  QuizHistoryDataService.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 02.08.2025.
//

import Foundation
import CoreData
import Combine

final class QuizHistoryDataService {
    
    // MARK: - Published
    
    @Published
    var allQuizHistory: [QuizResult] = []
    
    // MARK: - Private Properties
    
    private let container: NSPersistentContainer
    
    private let containerName: String = "QuizResultContainer"
    
    private let entityName: String = "QuizResultEntity"
    
    // MARK: - Init
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { [weak self] _, error in
            if let error = error {
                print("❌ Error loading Core Data: \(error.localizedDescription)")
            } else {
                self?.loadQuizHistory()
            }
        }
    }
    
    // MARK: - Public Methods
    
    func saveQuizResult(result: QuizResult) {
        add(result: result)
    }
    
    func deleteQuizResult(result: QuizResult) {
        guard let entity = fetchEntity(by: result.id) else { return }
        remove(entity: entity)
    }
    
    // MARK: - Private Methods
    
    private func loadQuizHistory() {
        let request = NSFetchRequest<QuizResultEntity>(entityName: entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let entities = try container.viewContext.fetch(request)
            allQuizHistory = entities.map (mapEntityToModel)
        } catch {
            print("❌ Failed to fetch quiz history: \(error)")
        }
    }
    
    private func mapEntityToModel(_ entity: QuizResultEntity) -> QuizResult {
        let questions: [AnsweredQuestion] = (entity.answeredQuestions as? Set<AnsweredQuestionEntity>)?.compactMap { qEntity in
            AnsweredQuestion(
                questionText: qEntity.questionText ?? "",
                allAnswers: qEntity.allAnswers as? [String] ?? [],
                selectedAnswer: qEntity.selectedAnswer,
                correctAnswer: qEntity.correctAnswer ?? ""
            )
        } ?? []
        
        return QuizResult(
            date: entity.date ?? Date(),
            answeredQuestions: questions
        )
    }
    
    private func add(result: QuizResult) {
        let entity = QuizResultEntity(context: container.viewContext)
        
        entity.id = result.id
        entity.date = result.date
        entity.totalQuestions = Int16(result.answeredQuestions.count)
        entity.score = Int16(result.correctAnswersCount)
        entity.category = "General"
        entity.difficulty = "Any"
        
        result.answeredQuestions.forEach { answered in
            let qEntity = AnsweredQuestionEntity(context: container.viewContext)
            qEntity.id = answered.id
            qEntity.questionText = answered.questionText
            qEntity.correctAnswer = answered.correctAnswer
            qEntity.selectedAnswer = answered.selectedAnswer
            qEntity.allAnswers = answered.allAnswers as NSArray
            qEntity.quizResult = entity
        }
        
        applyChanges()
    }
    
    private func remove(entity: QuizResultEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func fetchEntity(by id: UUID) -> QuizResultEntity? {
        let request = NSFetchRequest<QuizResultEntity>(entityName: entityName)
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        return try? container.viewContext.fetch(request).first
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        loadQuizHistory()
    }
    
}

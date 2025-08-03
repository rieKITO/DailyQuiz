//
//  QuizView.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 01.08.2025.
//

import SwiftUI

struct QuizView: View {
    
    // MARK: - View Model
    
    @EnvironmentObject
    private var quizViewModel: QuizViewModel
    
    @EnvironmentObject
    private var historyViewModel: QuizHistoryViewModel
    
    // MARK: - Computed Properties
    
    private var shuffledAnswers: [String] {
        quizViewModel.currentQuizQuestionsShuffledAnswers?[quizViewModel.currentQuestionIndex] ?? []
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            VStack {
                header
                    .padding(.bottom, 30)
                QuestionSectionView(
                    questionText: quizViewModel.quizQuestions[quizViewModel.currentQuestionIndex].question,
                    shuffledAnswers: shuffledAnswers,
                    questionIndex: quizViewModel.currentQuestionIndex,
                    countOfQuestions: quizViewModel.quizQuestions.count,
                    mode: .quiz,
                    showFooterButton: true,
                    goNext: quizViewModel.goToNextQuestion,
                    selectedAnswer: $quizViewModel.selectedAnswer
                )
                .onChange(of: quizViewModel.quizIsFinished) { isFinished in
                    if let result = quizViewModel.lastResult, isFinished {
                        historyViewModel.saveResult(result: result)
                    }
                }
                footerText
                    .padding(.top, 8)
            }
            .padding(20)
            .padding(.top, 10)
            Spacer()
        }
    }
}

// MARK: - Layout

private extension QuizView {
    
    private var header: some View {
        Image("logo")
            .resizable()
            .frame(width: 180, height: 40)
    }
    
    private var footerText: some View {
        Text("Вернуться к предыдущим вопросам нельзя")
            .foregroundStyle(Color.appThemeColors.white)
            .font(.caption2)
    }
    
}

// MARK: - Preview

#Preview {
    ZStack {
        Color.appThemeColors.moodyBlue.ignoresSafeArea()
        QuizView()
            .environmentObject(DeveloperPreview.shared.quizViewModel)
            .environmentObject(DeveloperPreview.shared.historyViewModel)
    }
}

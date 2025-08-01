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
    private var viewModel: QuizViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 30) {
            header
            QuestionSectionView(
                question: viewModel.quizQuestions[viewModel.currentQuestionIndex],
                questionIndex: viewModel.currentQuestionIndex,
                countOfQuestions: viewModel.quizQuestions.count,
                showFooterButton: true,
                goNext: viewModel.goToNextQuestion,
                selectedAnswer: $viewModel.selectedAnswer
            )
            Spacer()
        }
        .padding(20)
        .padding(.top, 10)
    }
}

// MARK: - Layout

private extension QuizView {
    
    private var header: some View {
        Image("logo")
            .resizable()
            .frame(width: 180, height: 40)
    }
    
}

// MARK: - Preview

#Preview {
    ZStack {
        Color.appThemeColors.moodyBlue.ignoresSafeArea()
        QuizView()
            .environmentObject(DeveloperPreview.shared.quizViewModel)
    }
}

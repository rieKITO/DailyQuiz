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
        ZStack {
            //if !viewModel.quizIsFinished {
                VStack {
                    header
                        .padding(.bottom, 30)
                    QuestionSectionView(
                        question: viewModel.quizQuestions[viewModel.currentQuestionIndex],
                        questionIndex: viewModel.currentQuestionIndex,
                        countOfQuestions: viewModel.quizQuestions.count,
                        showFooterButton: true,
                        goNext: viewModel.goToNextQuestion,
                        selectedAnswer: $viewModel.selectedAnswer
                    )
                    footerText
                        .padding(.top, 8)
                }
                .padding(20)
                .padding(.top, 10)
            //}
//            } else {
//                if let result = viewModel.lastResult {
//                    QuizResultView(quizResult: result, showRepeatButton: true)
//                }
//            }
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
    }
}

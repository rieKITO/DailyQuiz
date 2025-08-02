//
//  QuizResultView.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 02.08.2025.
//

import SwiftUI

struct QuizResultView: View {
    
    // MARK: - Properties
    
    let quizResult: QuizResult
    
    let showAnswers: Bool
    
    let showRepeatButton: Bool
    
    let onRestart: (() -> Void)?
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // background
            Color.appThemeColors.moodyBlue.ignoresSafeArea()
            
            // foreground
            ScrollView {
                VStack {
                    header
                        .padding(.top, 32)
                        .padding(.bottom, 40)
                    resultSection
                        .padding(.horizontal, 26)
                    if showAnswers {
                        answers
                            .padding(.top, 36)
                    }
                    Spacer()
                }
            }
        }
    }
}

// MARK: - Layout

private extension QuizResultView {
    
    private var header: some View {
        Text("Результаты")
            .foregroundStyle(Color.appThemeColors.white)
            .font(.largeTitle)
            .fontWeight(.heavy)
    }
    
    private var resultSection: some View {
        VStack {
            Group {
                StarsView(rating: quizResult.correctAnswersCount, starSize: 52)
                correctAnswersCount
            }
            .padding(.bottom, 24)
            quizResultTitle
                .padding(.bottom, 12)
            quizResultSubtitle
            if showRepeatButton {
                repeatButton
                    .padding(.top, 64)
            }
        }
        .padding(32)
        .background(
            RoundedRectangle(cornerRadius: 46)
                .fill(Color.appThemeColors.white)
        )
    }
    
    private var correctAnswersCount: some View {
        Text("\(quizResult.correctAnswersCount) из \(quizResult.answeredQuestionsCount)")
            .foregroundStyle(Color.appThemeColors.yellow)
            .font(.headline)
            .fontWeight(.heavy)
    }
    
    private var quizResultTitle: some View {
        Text(quizResult.resultDescription.title)
            .foregroundStyle(Color.appThemeColors.accent)
            .font(.title)
            .fontWeight(.bold)
    }
    
    private var quizResultSubtitle: some View {
        Text(quizResult.resultDescription.subtitle)
            .foregroundStyle(Color.appThemeColors.accent)
            .multilineTextAlignment(.center)
    }
    
    private var repeatButton: some View {
        Button {
            onRestart?()
        } label: {
            RoundedRectangleButton(
                text: "НАЧАТЬ ЗАНОВО",
                textColor: Color.appThemeColors.white,
                backgroundColor: Color.appThemeColors.moodyBlue
            )
        }
    }
    
    private var answers: some View {
        VStack {
            Text("Твои ответы")
                .foregroundStyle(Color.appThemeColors.white)
                .font(.largeTitle)
                .fontWeight(.heavy)
            ForEach(Array(quizResult.answeredQuestions.enumerated()), id: \.element.id) { index, question in
                QuestionSectionView(
                    questionText: question.questionText,
                    allAnswers: question.allAnswers,
                    questionIndex: index,
                    countOfQuestions: quizResult.answeredQuestionsCount,
                    mode: .resultSection(correctAnswer: question.correctAnswer),
                    showFooterButton: false,
                    goNext: nil,
                    selectedAnswer: .constant(question.selectedAnswer)
                )
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
            }
        }
    }
    
}

// MARK: - Preview

#Preview("Repeat button + no answers") {
    ZStack {
        // background
        Color.appThemeColors.moodyBlue.ignoresSafeArea()
        // foreground
        QuizResultView(
            quizResult: DeveloperPreview.shared.quizResult,
            showAnswers: false,
            showRepeatButton: true,
            onRestart: nil
        )
    }
}

#Preview("No repeat button + answers") {
    ZStack {
        // background
        Color.appThemeColors.moodyBlue.ignoresSafeArea()
        // foreground
        QuizResultView(
            quizResult: DeveloperPreview.shared.quizResult,
            showAnswers: true,
            showRepeatButton: false,
            onRestart: nil
        )
    }
}

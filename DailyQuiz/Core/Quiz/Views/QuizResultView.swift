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
    
    let showRepeatButton: Bool
    
    let onRestart: (() -> Void)?
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            header
                .padding(.top, 32)
                .padding(.bottom, 40)
            resultSection
                .padding(.horizontal, 26)
            Spacer()
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
                StarsView(rating: quizResult.correctAnswersCount)
                correctAnswersCount
            }
            .padding(.bottom, 24)
            quizResultTitle
                .padding(.bottom, 12)
            quizResultSubtitle
            if showRepeatButton {
                Button {
                    onRestart?()
                } label: {
                    RoundedRectangleButton(
                        text: "НАЧАТЬ ЗАНОВО",
                        textColor: Color.appThemeColors.white,
                        backgroundColor: Color.appThemeColors.moodyBlue
                    )
                }
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
    
}

// MARK: - Preview

#Preview {
    ZStack {
        // background
        Color.appThemeColors.moodyBlue.ignoresSafeArea()
        // foreground
        QuizResultView(quizResult: DeveloperPreview.shared.quizResult, showRepeatButton: true, onRestart: nil)
    }
}

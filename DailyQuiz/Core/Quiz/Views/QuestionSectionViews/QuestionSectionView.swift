//
//  QuestionSectionView.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 01.08.2025.
//

import SwiftUI

struct QuestionSectionView: View {
    
    // MARK: - Init Properties
    
    let questionText: String
    
    let allAnswers: [String]
    
    let questionIndex: Int
    
    let countOfQuestions: Int
    
    // next button
    
    let showFooterButton: Bool
    
    let goNext: (() -> Void)?
    
    // MARK: - Binding
    
    @Binding
    var selectedAnswer: String?
    
    // MARK: - State
    
    @State
    private var shuffledAnswers: [String] = []
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            questionNumber
                .padding(.bottom, 20)
            questionTextLabel
                .padding(.bottom, 15)
            answers
            if showFooterButton {
                footerButton
                    .padding(.top, 67)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .padding(.horizontal, 30)
        .background(
            RoundedRectangle(cornerRadius: 45)
                .foregroundStyle(Color.appThemeColors.white)
        )
        .onAppear {
            if shuffledAnswers.isEmpty {
                shuffledAnswers = getShuffledAnswers(answers: allAnswers)
            }
        }
        .onChange(of: questionText) {  _ in
            shuffledAnswers = getShuffledAnswers(answers: allAnswers)
        }
    }
}

// MARK: - Layout

private extension QuestionSectionView {
    
    private var questionNumber: some View {
        Text("Вопрос \(questionIndex + 1) из \(countOfQuestions)")
            .foregroundStyle(Color.appThemeColors.paleBlue)
            .font(.headline)
            .bold()
    }
    
    private var questionTextLabel: some View {
        Text(questionText.removingHTMLOccurances)
            .font(.title3)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .lineLimit(4)
            .minimumScaleFactor(0.5)
    }
    
    private var answers: some View {
        ForEach(shuffledAnswers, id: \.self) { answer in
            AnswerRowView(answer: answer, isSelected: selectedAnswer == answer)
                .padding(.vertical, 5)
                .onTapGesture {
                    selectedAnswer = answer
                }
        }
    }
    
    private var footerButton: some View {
        Button {
            goNext?()
        } label: {
            RoundedRectangleButton(
                text: questionIndex < countOfQuestions - 1 ? "ДАЛЕЕ" : "ЗАВЕРШИТЬ",
                textColor: selectedAnswer == nil ? Color.appThemeColors.lightGray : Color.appThemeColors.white,
                backgroundColor: selectedAnswer == nil ? Color.appThemeColors.gray : Color.appThemeColors.moodyBlue
            )
        }
        .disabled(selectedAnswer == nil)
    }
    
}

// MARK: - Private Methods

private extension QuestionSectionView {
    
    private func getShuffledAnswers(answers: [String]) -> [String] {
        return answers.shuffled()
    }
    
}

// MARK: - Preview

#Preview {
    struct Preview: View {
        
        @State
        private var selectedAnswer: String? = nil
        
        var body: some View {
            ZStack {
                //background
                Color.appThemeColors.moodyBlue.ignoresSafeArea()
                // foreground
                QuestionSectionView(
                    questionText: DeveloperPreview.shared.question.question,
                    allAnswers: DeveloperPreview.shared.question.incorrectAnswers + [DeveloperPreview.shared.question.correctAnswer],
                    questionIndex: 1,
                    countOfQuestions: 5,
                    showFooterButton: true,
                    goNext: nil,
                    selectedAnswer: $selectedAnswer
                )
                .padding()
            }
        }
    }
    return Preview()
}

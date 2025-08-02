//
//  QuestionSectionView.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 01.08.2025.
//

import SwiftUI

enum questionSectionMode: Equatable {
    case quiz
    case resultSection(correctAnswer: String)
}

struct QuestionSectionView: View {
    
    // MARK: - Init Properties
    
    let questionText: String
    
    let shuffledAnswers: [String]
    
    let questionIndex: Int
    
    let countOfQuestions: Int
    
    let mode: questionSectionMode
    
    // next button
    
    let showFooterButton: Bool
    
    let goNext: (() -> Void)?
    
    // MARK: - Binding
    
    @Binding
    var selectedAnswer: String?
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            HStack {
                questionNumber
                if mode != .quiz {
                    Spacer()
                    questionStatus
                }
            }
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
            AnswerRowView(answer: answer, answerState: getAnswerState(answer: answer))
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
    
    private var questionStatus: some View {
        let state = getAnswerState(answer: selectedAnswer ?? "")
        return Group {
            if state == .correct || state == .incorrect {
                ZStack {
                    Circle()
                        .fill(state.answerColor)
                        .frame(width: 20, height: 20)
                    state.circleImage
                        .resizable()
                        .frame(width: 9, height: 9)
                        .foregroundStyle(Color.appThemeColors.white)
                }
            }
        }
    }
    
}

// MARK: - Private Methods

private extension QuestionSectionView {
    
    private func getShuffledAnswers(answers: [String]) -> [String] {
        return answers.shuffled()
    }
    
    private func getAnswerState(answer: String) -> AnswerState {
        switch mode {
        case .quiz:
            return selectedAnswer == answer ? .selected : .normal
        case .resultSection(let correctAnswer):
            if selectedAnswer == answer {
                return answer == correctAnswer ? .correct : .incorrect
            } else {
                return .normal
            }
        }
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
                    shuffledAnswers: (DeveloperPreview.shared.question.incorrectAnswers + [DeveloperPreview.shared.question.correctAnswer]).shuffled(),
                    questionIndex: 1,
                    countOfQuestions: 5,
                    mode: .quiz,
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

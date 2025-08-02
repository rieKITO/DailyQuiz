//
//  AnswerRowView.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 01.08.2025.
//

import SwiftUI

enum AnswerState {
    case normal
    case selected
    case correct
    case incorrect
    
    var answerColor: Color {
        switch self {
        case .normal: Color.appThemeColors.accent
        case .selected: Color.appThemeColors.deepPurple
        case .correct: Color.appThemeColors.green
        case .incorrect: Color.appThemeColors.red
        }
    }
    
    var circleImage: Image {
        switch self {
        case .selected, .correct: Image("custom_checkmark")
        case .incorrect: Image(systemName: "xmark")
        default: Image("")
        }
    }
}

struct AnswerRowView: View {
    
    // MARK: - Init Properties
    
    let answer: String
    
    let answerState: AnswerState
    
    // MARK: - Private Properties
    
    let circleSize: CGFloat = 24.0
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 25) {
            checkmarkCircle
            Text(answer.removingHTMLOccurances)
                .minimumScaleFactor(0.5)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .padding(.horizontal, 4)
        .background(backgroundRectangle)
    }
}

// MARK: - Layout

private extension AnswerRowView {
    
    private var checkmarkCircle: some View {
        ZStack {
            Circle()
                .stroke(answerState.answerColor, lineWidth: 1)
                .frame(width: circleSize, height: circleSize)
            if answerState != .normal {
                answerState.circleImage
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(Color.appThemeColors.white)
                    .background(
                        Circle()
                            .fill(answerState.answerColor)
                            .frame(width: circleSize, height: circleSize)
                    )
            }
        }
    }
    
    private var backgroundRectangle: some View {
        Group {
            if answerState != .normal {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(answerState.answerColor, lineWidth: 1)
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color.appThemeColors.lightGray)
            }
        }
    }
    
}

// MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        AnswerRowView(answer: "Яблоко", answerState: .normal)
        AnswerRowView(answer: "Яблоко", answerState: .selected)
        AnswerRowView(answer: "Яблоко", answerState: .correct)
        AnswerRowView(answer: "Яблоко", answerState: .incorrect)
    }
    .padding(.horizontal, 40)
}

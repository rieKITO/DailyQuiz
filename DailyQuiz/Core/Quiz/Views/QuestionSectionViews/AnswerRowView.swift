//
//  AnswerRowView.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 01.08.2025.
//

import SwiftUI

struct AnswerRowView: View {
    
    // MARK: - Init Properties
    
    let answer: String
    
    let isSelected: Bool
    
    // MARK: - Private Properties
    
    let circleSize: CGFloat = 24.0
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 25) {
            checkmarkCircle
            Text(answer)
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
                .stroke(
                    isSelected ? Color.appThemeColors.deepPurple : Color.appThemeColors.accent,
                    lineWidth: 1
                )
                .frame(width: circleSize, height: circleSize)
            if isSelected {
                Image("custom_checkmark")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .background(
                        Circle()
                            .fill(Color.appThemeColors.deepPurple)
                            .frame(width: circleSize, height: circleSize)
                    )
            }
        }
    }
    
    private var backgroundRectangle: some View {
        Group {
            if isSelected {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.appThemeColors.deepPurple, lineWidth: 1)
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
        AnswerRowView(answer: "Яблоко", isSelected: false)
        AnswerRowView(answer: "Яблоко", isSelected: true)
    }
    .padding(.horizontal, 40)
}

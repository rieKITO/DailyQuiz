//
//  HistoryItemRowView.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 02.08.2025.
//

import SwiftUI

struct HistoryItemRowView: View {
    
    // MARK: - Init Properties
    
    let quizResult: QuizResult
    
    let quizIndex: Int
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Quiz \(quizIndex + 1)")
                    .foregroundStyle(Color.appThemeColors.deepPurple)
                    .font(.title)
                    .fontWeight(.heavy)
                Spacer()
                StarsView(rating: quizResult.correctAnswersCount, starSize: 13)
            }
            HStack {
                Text(DateFormatterHelper.formatToDayMonthString(date: quizResult.date))
                Spacer()
                Text(DateFormatterHelper.formatTime(date: quizResult.date))
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.appThemeColors.white)
        )
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        // background
        Color.appThemeColors.moodyBlue.ignoresSafeArea()
        // foreground
        HistoryItemRowView(
            quizResult: DeveloperPreview.shared.quizResult,
            quizIndex: 0
        )
        .padding(.horizontal)
    }
}

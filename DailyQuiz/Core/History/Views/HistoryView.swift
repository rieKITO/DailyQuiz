//
//  HistoryView.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 02.08.2025.
//

import SwiftUI

struct HistoryView: View {
    
    // MARK: - View Model
    
    @EnvironmentObject
    private var historyViewModel: QuizHistoryViewModel
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // background
            Color.appThemeColors.moodyBlue.ignoresSafeArea()
            
            // foreground
            VStack {
                header
                Text("\(historyViewModel.quizHistory[0].correctAnswersCount)")
                Spacer()
            }
        }
        
    }
}

// MARK: - Layout

private extension HistoryView {
    
    private var header: some View {
        ZStack {
            Text("История")
                .foregroundStyle(Color.appThemeColors.white)
                .font(.largeTitle)
                .fontWeight(.heavy)
            HStack {
                BackButton()
                Spacer()
            }
            .padding(.horizontal, 30)
        }
        .padding(.vertical, 25)
    }
    
}

// MARK: - Preview

#Preview {
    HistoryView()
        .environmentObject(DeveloperPreview.shared.historyViewModel)
}

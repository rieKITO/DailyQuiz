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
                    .padding(.top, 25)
                    .padding(.bottom, 40)
                quizList
                //Spacer()
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
    }
    
    private var quizList: some View {
        ScrollView {
            LazyVStack {
                ForEach(Array(historyViewModel.quizHistory.enumerated()), id: \.element.id) { index, quiz in
                    NavigationLink(value: quiz) {
                        HistoryItemRowView(quizResult: quiz, quizIndex: index)
                            .padding(.bottom, 10)
                            .padding(.horizontal, 25)
                    }
                }
            }
        }
        .navigationDestination(for: QuizResult.self) { quiz in
            QuizResultView(
                quizResult: quiz,
                showAnswers: true,
                showRepeatButton: false,
                onRestart: nil
            )
        }
    }
    
}

// MARK: - Preview

#Preview {
    NavigationStack {
        HistoryView()
            .environmentObject(DeveloperPreview.shared.historyViewModel)
    }
}

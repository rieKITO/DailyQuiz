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
    
    // MARK: - Environment
    
    @Environment(\.dismiss)
    private var dismiss
    
    // MARK: - Binding
    
    @Binding
    var showFilters: Bool
    
    // MARK: - State
    
    @State
    private var showDeleteTopic: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // background
            Color.appThemeColors.moodyBlue.ignoresSafeArea()
            
            // foreground
            VStack {
                header
                    .padding(.top, 25)
                if historyViewModel.quizHistory.isEmpty {
                    emptyHistoryView
                        .padding(.horizontal)
                        .padding(.top, 30)
                    Spacer()
                    Image("logo")
                        .resizable()
                        .frame(width: 180, height: 40)
                        .padding(.bottom, 70)
                } else {
                    quizList
                }
            }
            if showDeleteTopic {
                deleteTopic
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
    
    private var emptyHistoryView: some View {
        VStack {
            Text("Вы еще не проходили ни одной викторины")
                .foregroundStyle(Color.appThemeColors.accent)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.bottom, 40)
            Button {
                showFilters = true
                dismiss.callAsFunction()
            } label: {
                RoundedRectangleButton(
                    text: "НАЧАТЬ ВИКТОРИНУ",
                    textColor: Color.appThemeColors.white,
                    backgroundColor: Color.appThemeColors.moodyBlue
                )
            }
        }
        .padding(32)
        .background(
            RoundedRectangle(cornerRadius: 46)
                .fill(Color.appThemeColors.white)
        )
    }
    
    private var quizList: some View {
        ScrollView {
            LazyVStack {
                ForEach(Array(historyViewModel.quizHistory.enumerated()), id: \.element.id) { index, quiz in
                    NavigationLink(value: quiz) {
                        HistoryItemRowView(quizResult: quiz, quizIndex: index)
                            .contextMenu {
                                Group {
                                    Button {
                                        withAnimation {
                                            historyViewModel.deleteResult(result: quiz)
                                            showDeleteTopic = true
                                        }
                                    } label: {
                                        HStack {
                                            Text("Удалить")
                                            Image("custom_trash")
                                        }
                                        .foregroundStyle(Color.appThemeColors.red)
                                    }

                                }
                            }
                            .padding(.bottom, 10)
                            .padding(.horizontal, 25)
                    }
                }
            }
            .padding(.top, 40)
        }
        .navigationDestination(for: QuizResult.self) { quiz in
            QuizResultView(
                quizResult: quiz,
                showAnswers: true,
                showRepeatButton: false,
                onRestart: nil
            )
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private var deleteTopic: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .transition(.opacity)
            VStack {
                Text("Попытка удалена")
                    .foregroundColor(Color.appThemeColors.accent)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 12)
                Text("Вы можете пройти викторину снова, когда будете готовы.")
                    .foregroundColor(Color.appThemeColors.accent)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                Button {
                    withAnimation {
                        showDeleteTopic = false
                    }
                } label: {
                    RoundedRectangleButton(
                        text: "ХОРОШО",
                        textColor: Color.appThemeColors.white,
                        backgroundColor: Color.appThemeColors.moodyBlue
                    )
                }
            }
            .padding(32)
            .background(
                RoundedRectangle(cornerRadius: 46)
                    .fill(Color.appThemeColors.white)
            )
            .padding(.horizontal, 26)
        }
    }
    
}

// MARK: - Preview

#Preview {
    NavigationStack {
        HistoryView(showFilters: .constant(false))
            .environmentObject(DeveloperPreview.shared.historyViewModel)
    }
}

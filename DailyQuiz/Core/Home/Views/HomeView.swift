//
//  HomeView.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 01.08.2025.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - View Models
    
    @StateObject
    private var viewModel = QuizViewModel()
    
    @StateObject
    private var historyViewModel = QuizHistoryViewModel()
    
    // MARK: - State
    
    @State
    private var showQuiz: Bool = false
    
    @State
    private var showErrorMessage: Bool = false
    
    @State
    private var showHistory: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            //background
            Color.appThemeColors.moodyBlue.edgesIgnoringSafeArea(.all)
            
            // foreground
            if viewModel.isLoading {
                VStack {
                    logo
                        .padding(.top, 224)
                        .padding(.bottom, 130)
                    loader
                    Spacer()
                }
            } else if showQuiz && !viewModel.quizQuestions.isEmpty && !viewModel.quizIsFinished {
                QuizView()
                    .environmentObject(viewModel)
                    .environmentObject(historyViewModel)
            } else if viewModel.quizIsFinished {
                if let result = viewModel.lastResult {
                    QuizResultView(
                        quizResult: result,
                        showAnswers: false,
                        showRepeatButton: true
                    ) {
                        viewModel.restart()
                    }
                }
            } else {
                VStack {
                    historyButton
                        .padding(.top, 46)
                        .padding(.bottom, 114)
                        .navigationDestination(for: String.self) { value in
                            if value == "history" {
                                HistoryView(showQuiz: $showQuiz)
                                    .navigationBarBackButtonHidden(true)
                                    .environmentObject(historyViewModel)
                            }
                        }
                    logo
                        .padding(.bottom, 40)
                    startQuizSection
                        .padding(.horizontal)
                    if  showErrorMessage {
                        errorMessage
                            .padding(.top, 15)
                    }
                    Spacer()
                }
            }
        }
        .onChange(of: showQuiz) { newValue in
            if newValue {
                viewModel.loadQuizQuestions()
                showErrorMessage = viewModel.quizQuestions.isEmpty ? true : false
            }
        }
        .onChange(of: viewModel.quizIsFinished) { isFinished in
            if isFinished {
                showQuiz = false
            }
        }
    }
}

// MARK: - Layout

private extension HomeView {
    
    private var historyButton: some View {
        NavigationLink(value: "history") {
            HStack(spacing: 20) {
                Text("История")
                    .foregroundStyle(Color.appThemeColors.moodyBlue)
                    .font(.headline)
                Image("history")
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(Color.appThemeColors.white)
            )
        }
    }
    
    private var logo: some View {
        Image("logo")
            .resizable()
            .frame(width: 300, height: 68)
    }
    
    private var startQuizSection: some View {
        VStack(spacing: 40) {
            Text("Добро пожаловать в DailyQuiz!")
                .foregroundStyle(Color.appThemeColors.accent)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            Button {
                showQuiz = true
                viewModel.loadQuizQuestions()
                showErrorMessage = viewModel.quizQuestions.isEmpty ? true : false
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
                .foregroundStyle(Color.appThemeColors.white)
        )
    }
    
    private var errorMessage: some View {
        Text("Ошибка! Попробуйте ещё раз")
            .foregroundStyle(Color.appThemeColors.white)
            .font(.title3)
            .fontWeight(.heavy)
    }
    
    private var loader: some View {
        Image("loader")
            .resizable()
            .frame(width: 54, height: 54)
    }
    
}

// MARK: - Preview

#Preview {
    NavigationStack {
        HomeView()
            .toolbar(.hidden)
            .environmentObject(DeveloperPreview.shared.quizViewModel)
            .environmentObject(DeveloperPreview.shared.historyViewModel)
    }
}

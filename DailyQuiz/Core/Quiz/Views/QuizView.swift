//
//  QuizView.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 01.08.2025.
//

import SwiftUI

struct QuizView: View {
    
    // MARK: - View Model
    
    @EnvironmentObject
    private var quizViewModel: QuizViewModel
    
    @EnvironmentObject
    private var historyViewModel: QuizHistoryViewModel
    
    // MARK: - Binding
    
    @Binding
    var showQuiz: Bool
    
    // MARK: - Computed Properties
    
    private var shuffledAnswers: [String] {
        quizViewModel.currentQuizQuestionsShuffledAnswers?[quizViewModel.currentQuestionIndex] ?? []
    }
    
    // MARK: - State
    
    @State
    private var timer: Timer?
    
    @State
    private var elapsedTime: TimeInterval = 0
    
    @State
    private var isTimeout: Bool = false
    
    // MARK: - Private Properties
    
    private let quizDuration: TimeInterval = 10
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            VStack {
                header
                    .padding(.bottom, 15)
                if quizViewModel.currentQuestionIndex < quizViewModel.quizQuestions.count {
                    QuestionSectionView(
                        questionText: quizViewModel.quizQuestions[quizViewModel.currentQuestionIndex].question,
                        shuffledAnswers: shuffledAnswers,
                        questionIndex: quizViewModel.currentQuestionIndex,
                        countOfQuestions: quizViewModel.quizQuestions.count,
                        mode: .quiz,
                        showFooterButton: true,
                        goNext: quizViewModel.goToNextQuestion,
                        elapsedTime: elapsedTime,
                        totalTime: quizDuration,
                        selectedAnswer: $quizViewModel.selectedAnswer
                    )
                    .onChange(of: quizViewModel.quizIsFinished) { isFinished in
                        if let result = quizViewModel.lastResult, isFinished {
                            historyViewModel.saveResult(result: result)
                            stopTimer()
                        }
                    }
                    .disabled(isTimeout)
                    footerText
                        .padding(.top, 8)
                }
            }
            .padding(20)
            .padding(.top, 10)
            Spacer()
            if isTimeout {
                endTimeTopic
            }
        }
        .onAppear { startTimer() }
        .onDisappear { stopTimer() }
        
    }
}

// MARK: - Layout

private extension QuizView {
    
    private var header: some View {
        Image("logo")
            .resizable()
            .frame(width: 180, height: 40)
    }
    
    private var footerText: some View {
        Text("Вернуться к предыдущим вопросам нельзя")
            .foregroundStyle(Color.appThemeColors.white)
            .font(.caption2)
    }
    
    private var endTimeTopic: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .transition(.opacity)
            VStack {
                Text("Время вышло!")
                    .foregroundColor(Color.appThemeColors.accent)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 12)
                Group {
                    Text("Вы не успели пройти викторину.")
                    Text("Попробуйте еще раз!")
                        .padding(.bottom, 40)
                }
                .foregroundColor(Color.appThemeColors.accent)
                .multilineTextAlignment(.center)
                Button {
                    withAnimation {
                        quizViewModel.restart()
                        showQuiz = false
                    }
                } label: {
                    RoundedRectangleButton(
                        text: "НАЧАТЬ ЗАНОВО",
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
            .padding(.horizontal, 13)
        }
    }
    
}

// MARK: - Timer Methods

private extension QuizView {
    
    private func startTimer() {
        timer?.invalidate()
        elapsedTime = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            elapsedTime += 1
            if elapsedTime >= quizDuration {
                stopTimer()
                withAnimation {
                    isTimeout = true
                }
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}

// MARK: - Preview

#Preview {
    ZStack {
        Color.appThemeColors.moodyBlue.ignoresSafeArea()
        QuizView(showQuiz: .constant(true))
            .environmentObject(DeveloperPreview.shared.quizViewModel)
            .environmentObject(DeveloperPreview.shared.historyViewModel)
    }
}

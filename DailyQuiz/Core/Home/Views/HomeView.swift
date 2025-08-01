//
//  HomeView.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 01.08.2025.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - State
    
    @StateObject
    private var viewModel = QuizViewModel()
    
    @State
    private var showQuiz: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            //background
            Color.appThemeColors.moodyBlue.edgesIgnoringSafeArea(.all)
            
            // foreground
            if !showQuiz {
                VStack {
                    historyButton
                        .padding(.top, 80)
                        .padding(.bottom, 100)
                    logo
                        .padding(.bottom, 30)
                    startQuizSection
                        .padding(.horizontal)
                    Spacer()
                }
            } else {
                if !viewModel.quizQuestions.isEmpty {
                    QuizView()
                        .environmentObject(viewModel)
                        .transition(.move(edge: .trailing))
                }
            }
        }
    }
}

// MARK: - Layout

private extension HomeView {
    
    private var historyButton: some View {
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
    
    private var logo: some View {
        Image("logo")
            .resizable()
            .frame(width: 300, height: 68)
    }
    
    private var startQuizSection: some View {
        VStack(spacing: 45) {
            Text("Добро пожаловать в DailyQuiz!")
                .foregroundStyle(Color.appThemeColors.accent)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            Button {
                showQuiz.toggle()
            } label: {
                RoundedRectangleButton(
                    text: "НАЧАТЬ ВИКТОРИНУ",
                    textColor: Color.appThemeColors.white,
                    backgroundColor: Color.appThemeColors.moodyBlue
                )
            }
        }
        .padding(.vertical, 30)
        .padding(.horizontal, 45)
        .background(
            RoundedRectangle(cornerRadius: 45)
                .foregroundStyle(Color.appThemeColors.white)
        )
    }
    
}

// MARK: - Preview

#Preview {
    HomeView()
        .environmentObject(DeveloperPreview.shared.quizViewModel)
}

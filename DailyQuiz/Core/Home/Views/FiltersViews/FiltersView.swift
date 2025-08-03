//
//  FiltersView.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 03.08.2025.
//

import SwiftUI

struct FiltersView: View {
    
    // MARK: - View Model
    
    @EnvironmentObject
    private var quizViewModel: QuizViewModel
    
    // MARK: - State
    
    @State
    private var showCategorySheet = false
    
    @State
    private var showDifficultySheet = false
    
    // MARK: - Init Properties
    
    var onContinue: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // background
            Color.appThemeColors.moodyBlue.ignoresSafeArea()
            
            // foreground
            VStack {
                header
                    .padding(.bottom, 52)
                VStack {
                    title
                        .padding(.bottom, 12)
                    subtitile
                        .padding(.bottom, 30)
                    filterRows
                        .padding(.bottom, 75)
                    footerButton
                }
                .padding(32)
                .background(
                    RoundedRectangle(cornerRadius: 46)
                        .fill(Color.appThemeColors.white)
                )
                Spacer()
            }
            .padding(20)
            .padding(.top, 10)
        }
        .sheet(isPresented: $showCategorySheet) {
            FilterSelectionSheet(
                title: "Категория",
                items: QuizCategory.allCases,
                selected: quizViewModel.filters.category.flatMap { QuizCategory(rawValue: $0) },
                displayName: { $0.displayName }
            ) { category in
                quizViewModel.filters.category = category.rawValue
            }
        }
        .sheet(isPresented: $showDifficultySheet) {
            FilterSelectionSheet(
                title: "Сложность",
                items: QuizDifficulty.allCases,
                selected: quizViewModel.filters.difficulty.flatMap { QuizDifficulty(rawValue: $0) },
                displayName: { $0.displayName }
            ) { difficulty in
                quizViewModel.filters.difficulty = difficulty.rawValue
            }
        }
    }
}

// MARK: - Layout

private extension FiltersView {
    
    private var header: some View {
        Image("logo")
            .resizable()
            .frame(width: 180, height: 40)
    }
    
    private var title: some View {
        Text("Почти готовы!")
            .foregroundColor(Color.appThemeColors.accent)
            .font(.title)
            .fontWeight(.bold)
    }
    
    private var subtitile: some View {
        Text("Осталось выбрать категорию и сложность викторины.")
            .foregroundColor(Color.appThemeColors.accent)
            .multilineTextAlignment(.center)
    }
    
    private var filterRows: some View {
        VStack {
            Button {
                showCategorySheet = true
            } label: {
                FilterRowView(
                    name: "Категория",
                    value: quizViewModel.filters.category
                              .flatMap { QuizCategory(rawValue: $0)?.displayName }
                              ?? nil)
            }
            .padding(.bottom, 16)

            Button {
                showDifficultySheet = true
            } label: {
                FilterRowView(
                    name: "Сложность",
                    value: quizViewModel.filters.difficulty
                              .flatMap { QuizDifficulty(rawValue: $0)?.displayName }
                              ?? nil)
            }
        }
    }
    
    private var footerButton: some View {
        Button {
            onContinue()
        } label: {
            RoundedRectangleButton(
                text: "ДАЛЕЕ",
                textColor: quizViewModel.filters.category == nil && quizViewModel.filters.difficulty == nil ? Color.appThemeColors.lightGray : Color.appThemeColors.white,
                backgroundColor: quizViewModel.filters.category == nil && quizViewModel.filters.difficulty == nil ? Color.appThemeColors.gray : Color.appThemeColors.moodyBlue
            )
        }
    }
    
}

// MARK: - Preview

#Preview {
    FiltersView(onContinue: {})
        .environmentObject(DeveloperPreview.shared.quizViewModel)
}

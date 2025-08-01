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
    private var viewModel: QuizViewModel
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            Text("Hello")
            ForEach(viewModel.quizQuestions) { question in
                Text(question.question)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    QuizView()
        .environmentObject(DeveloperPreview.shared.quizViewModel)
}

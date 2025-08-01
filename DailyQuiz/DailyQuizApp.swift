//
//  DailyQuizApp.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 01.08.2025.
//

import SwiftUI

@main
struct DailyQuizApp: App {
    
    @StateObject
    private var viewModel = QuizViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
            .environmentObject(viewModel)
        }
    }
}

//
//  HomeView.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 01.08.2025.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            //background
            Color.appThemeColors.moodyBlue.edgesIgnoringSafeArea(.all)
            
            // foreground
            VStack {
                historyButton
                logo
                VStack {
                    Text("Добро пожаловать в DailyQuiz!")
                        .foregroundStyle(Color.appThemeColors.accent)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(Color.appThemeColors.white)
                )
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
    
}

// MARK: - Preview

#Preview {
    HomeView()
}

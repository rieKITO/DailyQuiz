//
//  LoaderView.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 03.08.2025.
//

import SwiftUI

struct LoaderView: View {
    
    // MARK: - State
    
    @State
    private var isAnimating = false
    
    // MARK: - Body
    
    var body: some View {
        Image("loader")
            .resizable()
            .frame(width: 54, height: 54)
            .rotationEffect(.degrees(isAnimating ? 90 : 0))
            .animation(
                .linear(duration: 1).repeatForever(autoreverses: false)
                , value: isAnimating
            )
            .onAppear { isAnimating = true }
    }
    
}

// MARK: - Preview

#Preview {
    ZStack {
        Color.appThemeColors.moodyBlue
        LoaderView()
    }
}

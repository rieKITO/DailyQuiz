//
//  RoundedRectangleButton.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 01.08.2025.
//

import SwiftUI

struct RoundedRectangleButton: View {
    
    // MARK: - Properties
    
    let text: String
    
    let textColor: Color
    
    let backgroundColor: Color
    
    // MARK: - Body
    
    var body: some View {
        Text(text)
            .foregroundStyle(textColor)
            .font(.headline)
            .fontWeight(.heavy)
            .frame(maxWidth: .infinity)
            .padding()
            .padding(.horizontal, 30)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(backgroundColor)
            )
    }
}

// MARK: - Preview

#Preview {
    RoundedRectangleButton(
        text: "НАЧАТЬ ВИКТОРИНУ",
        textColor: Color.appThemeColors.white,
        backgroundColor: Color.appThemeColors.moodyBlue
    )
    .padding(.horizontal)
}

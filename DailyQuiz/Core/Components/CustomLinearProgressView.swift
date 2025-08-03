//
//  CustomLinearProgressView.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 03.08.2025.
//

import SwiftUI

struct CustomLinearProgressView: View {
    
    // MARK: - Init Properties
    
    var progress: Double
    
    // MARK: - Body

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 46)
                    .frame(height: 10)
                    .foregroundStyle(Color.gray.opacity(0.3))
                RoundedRectangle(cornerRadius: 46)
                    .frame(width: geometry.size.width * progress, height: 10)
                    .foregroundStyle(Color.appThemeColors.deepPurple)
            }
        }
        .frame(height: 10)
    }
}

// MARK: - Preview

#Preview {
    CustomLinearProgressView(progress: 0.5)
        .padding(.horizontal)
}

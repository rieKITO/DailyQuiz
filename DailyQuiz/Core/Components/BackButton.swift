//
//  BackButton.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 02.08.2025.
//

import SwiftUI

struct BackButton: View {
    
    // MARK: - Environment
    
    @Environment(\.dismiss)
    private var dismiss
    
    // MARK: - Body
    
    var body: some View {
        Button {
            dismiss.callAsFunction()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundStyle(Color.appThemeColors.white)
                .font(.headline)
        }

    }
}

// MARK: - Preview

#Preview {
    ZStack {
        // background
        Color.appThemeColors.moodyBlue.ignoresSafeArea()
        // foreground
        BackButton()
    }
}

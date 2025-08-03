//
//  FilterRowView.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 03.08.2025.
//

import SwiftUI

struct FilterRowView: View {
    
    // MARK: - Init Properties
    
    let name: String
    
    let value: String?
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            category
            Spacer()
            chevron
        }
        .foregroundStyle(Color.appThemeColors.accent)
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.appThemeColors.lightGray)
        )
    }
}

// MARK: - Layout

private extension FilterRowView {
    
    private var category: some View {
        VStack(alignment: .leading) {
            Text(name)
                .foregroundStyle(Color.appThemeColors.deepPurple)
                .font(.title3)
                .fontWeight(.bold)
            if let value = value {
                Text(value)
            }
        }
    }
    
    private var chevron: some View {
        Image(systemName: "chevron.right")
            .foregroundStyle(Color.appThemeColors.deepPurple)
            .font(.title3)
            .fontWeight(.medium)
    }
    
}

// MARK: - Preview

#Preview {
    FilterRowView(name: "Категория", value: "Книги")
        .padding(.horizontal)
}

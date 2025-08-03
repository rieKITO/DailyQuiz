//
//  FilterSelectionSheet.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 03.08.2025.
//

import SwiftUI

struct FilterSelectionSheet<T: Identifiable>: View {
    
    let title: String
    let items: [T]
    let selected: T?
    let displayName: (T) -> String
    let onSelect: (T) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color.appThemeColors.deepPurple)
                .padding(.top, 30)
            
            ForEach(items) { item in
                HStack {
                    Text(displayName(item))
                        .foregroundStyle(Color.appThemeColors.deepPurple)
                        .fontWeight(item.id == selected?.id ? .heavy : .medium)
                    Spacer()
                    if item.id == selected?.id {
                        Image(systemName: "checkmark")
                            .tint(Color.appThemeColors.deepPurple)
                            .fontWeight(.heavy)
                    }
                }
                .padding(.vertical, 4)
                .contentShape(Rectangle())
                .onTapGesture {
                    onSelect(item)
                }
            }
            Spacer()
        }
        .padding()
        .presentationDetents(
            [.height(CGFloat(items.count * 38 + 100))]
        )
        .presentationDragIndicator(.visible)
    }
}

// MARK: - Preview

#Preview {
    struct PreviewItem: Identifiable, CustomStringConvertible {
        let id = UUID()
        let name: String
        var description: String { name }
    }

    let mockItems = [
        PreviewItem(name: "Общие знания"),
        PreviewItem(name: "Книги"),
        PreviewItem(name: "Фильмы"),
        PreviewItem(name: "Музыка")
    ]

    return FilterSelectionSheet(
        title: "Категория",
        items: mockItems,
        selected: mockItems.first,
        displayName: \.name
    ) { _ in }
}

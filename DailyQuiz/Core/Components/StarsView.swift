//
//  StarsView.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 02.08.2025.
//

import SwiftUI

struct StarsView: View {
    
    let rating: Int
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(1..<6) { index in
                Image(index <= rating ? "star_fill" : "star")
                    .resizable()
                    .frame(width: 52, height: 52)
            }
        }
    }
}

#Preview {
    StarsView(rating: 2)
}

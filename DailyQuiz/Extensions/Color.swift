//
//  Color.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 01.08.2025.
//

import Foundation
import SwiftUI

extension Color {
    
    static let appThemeColors: ColorTheme = ColorTheme()
    
}

struct ColorTheme {
    
    let accent: Color = Color("CustomAccentColor")
    let background: Color = Color("CustomBackgroundColor")
    let deepPurple: Color = Color("CustomDeepPurpleColor")
    let gray: Color = Color("CustomGrayColor")
    let green: Color = Color("CustomGreenColor")
    let lightGray: Color = Color("CustomLightGrayColor")
    let moodyBlue: Color = Color("CustomMoodyBlueColor")
    let paleBlue: Color = Color("CustomPaleBlueColor")
    let red: Color = Color("CustomRedColor")
    let white: Color = Color("CustomWhiteColor")
    let yellow: Color = Color("CustomYellowColor")
    
}

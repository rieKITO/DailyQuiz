//
//  String.swift
//  DailyQuiz
//
//  Created by Александр Потёмкин on 02.08.2025.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        let noTags = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
        return noTags.decodingHTMLEntities()
    }
    
    func decodingHTMLEntities() -> String {
        var result = self
        let entities: [String: String] = [
            "&quot;": "\"",
            "&apos;": "'",
            "&amp;": "&",
            "&lt;": "<",
            "&gt;": ">",
            "&#039;": "'",
            "&shy;": ""
        ]
        
        for (entity, character) in entities {
            result = result.replacingOccurrences(of: entity, with: character)
        }
        
        return result
    }
    
}

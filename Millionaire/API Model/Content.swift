//
//  Content.swift
//  Millionaire
//
//  Created by Mikhail Ustyantsev on 26.02.2024.
//

import Foundation


struct Content: Codable {
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
}

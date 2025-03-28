//
//  Question.swift
//  QuizApp
//
//  Created by Vaisakh Suresh on 2025-03-28.
//

import Foundation
struct Question {
    var questionText: String
    var correctAnswer: String
    var incorrectAnswers: [String]
    
    init(questionText: String, correctAnswer: String, incorrectAnswers: [String]) {
        self.questionText = questionText
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers
    }
    
    // Returns all answers in a randomized order
    func getShuffledAnswers() -> [String] {
        var allAnswers = incorrectAnswers
        allAnswers.append(correctAnswer)
        return allAnswers.shuffled()
    }
}

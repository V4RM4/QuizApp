//
//  QuestionBank.swift
//  QuizApp
//
//  Created by Vaisakh Suresh on 2025-03-28.
//

import Foundation
class QuestionBank {
    static let shared = QuestionBank()
    
    private init() {}
    
    var questions: [Question] = []
    
    func addQuestion(_ question: Question) {
        questions.append(question)
    }
    
    func updateQuestion(at index: Int, with question: Question) {
        guard index >= 0 && index < questions.count else { return }
        questions[index] = question
    }
    
    func isEmpty() -> Bool {
        return questions.isEmpty
    }
}


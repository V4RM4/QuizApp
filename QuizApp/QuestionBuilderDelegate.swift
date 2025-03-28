//
//  QuestionBuilderDelegate.swift
//  QuizApp
//
//  Created by Vaisakh Suresh on 2025-03-28.
//

protocol QuestionBuilderDelegate: AnyObject {
    func didAddQuestion(_ question: Question)
    func didUpdateQuestion(at index: Int, with question: Question)
}

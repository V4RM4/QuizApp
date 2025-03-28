//
//  QuestionBuilderViewController.swift
//  QuizApp
//
//  Created by Vaisakh Suresh on 2025-03-28.
//
import UIKit
class QuestionBuilderViewController: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var correctAnswerTextField: UITextField!
    @IBOutlet weak var incorrectAnswer1TextField: UITextField!
    @IBOutlet weak var incorrectAnswer2TextField: UITextField!
    @IBOutlet weak var incorrectAnswer3TextField: UITextField!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
    weak var delegate: QuestionBuilderDelegate?
    var questionToEdit: Question?
    var editingIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightBarButton.title = questionToEdit != nil ? "Save" : "Done"
        
        // If editing, populate the fields
        if let question = questionToEdit {
            questionTextField.text = question.questionText
            correctAnswerTextField.text = question.correctAnswer
            
            if question.incorrectAnswers.count > 0 {
                incorrectAnswer1TextField.text = question.incorrectAnswers[0]
            }
            if question.incorrectAnswers.count > 1 {
                incorrectAnswer2TextField.text = question.incorrectAnswers[1]
            }
            if question.incorrectAnswers.count > 2 {
                incorrectAnswer3TextField.text = question.incorrectAnswers[2]
            }
        }
    }
    
    @IBAction func rightBarButtonTapped(_ sender: UIBarButtonItem) {
        // Validate inputs
        guard let questionText = questionTextField.text, !questionText.isEmpty,
              let correctAnswer = correctAnswerTextField.text, !correctAnswer.isEmpty,
              let incorrect1 = incorrectAnswer1TextField.text, !incorrect1.isEmpty,
              let incorrect2 = incorrectAnswer2TextField.text, !incorrect2.isEmpty,
              let incorrect3 = incorrectAnswer3TextField.text, !incorrect3.isEmpty else {
            
            let alert = UIAlertController(
                title: "Incomplete Question",
                message: "Please fill in all fields.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let incorrectAnswers = [incorrect1, incorrect2, incorrect3]
        let question = Question(
            questionText: questionText,
            correctAnswer: correctAnswer,
            incorrectAnswers: incorrectAnswers
        )
        
        if let index = editingIndex {
            delegate?.didUpdateQuestion(at: index, with: question)
        } else {
            delegate?.didAddQuestion(question)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        // Validate inputs
        guard let questionText = questionTextField.text, !questionText.isEmpty,
              let correctAnswer = correctAnswerTextField.text, !correctAnswer.isEmpty,
              let incorrect1 = incorrectAnswer1TextField.text, !incorrect1.isEmpty,
              let incorrect2 = incorrectAnswer2TextField.text, !incorrect2.isEmpty,
              let incorrect3 = incorrectAnswer3TextField.text, !incorrect3.isEmpty else {
            
            let alert = UIAlertController(
                title: "Incomplete Question",
                message: "Please fill in all fields.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let incorrectAnswers = [incorrect1, incorrect2, incorrect3]
        let question = Question(
            questionText: questionText,
            correctAnswer: correctAnswer,
            incorrectAnswers: incorrectAnswers
        )
        
        if let index = editingIndex {
            delegate?.didUpdateQuestion(at: index, with: question)
        } else {
            delegate?.didAddQuestion(question)
        }
        
        navigationController?.popViewController(animated: true)
    }
}

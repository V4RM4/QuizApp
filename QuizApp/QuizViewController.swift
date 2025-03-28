//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Vaisakh Suresh on 2025-03-28.
//

import UIKit
class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var optionLabel1: UILabel!
    @IBOutlet weak var optionLabel2: UILabel!
    @IBOutlet weak var optionLabel3: UILabel!
    @IBOutlet weak var optionLabel4: UILabel!
    
    private var currentQuestionIndex = 0
    private var userAnswers: [Int?] = []
    private var shuffledAnswers: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize user answers array with nil values
        userAnswers = Array(repeating: nil, count: QuestionBank.shared.questions.count)
        
        // Pre-shuffle all answers for consistency when navigating
        for question in QuestionBank.shared.questions {
            shuffledAnswers.append(question.getShuffledAnswers())
        }
        
        setupUI()
        loadQuestion(at: currentQuestionIndex)
    }
    
    func setupUI() {
        // Style the answer buttons to look like radio buttons
        for button in answerButtons {
            button.layer.cornerRadius = button.frame.height / 2 // Make them circular
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.systemBlue.cgColor
            button.backgroundColor = .white
            
            // Clear any existing title
            button.setTitle("", for: .normal)
        }
    }
    
    func loadQuestion(at index: Int) {
        guard index >= 0 && index < QuestionBank.shared.questions.count else { return }
        
        let question = QuestionBank.shared.questions[index]
        questionLabel.text = question.questionText
        
        // Update the answer labels with shuffled answers
        let answers = shuffledAnswers[index]
        
        // Create an array of the labels for easier access
        let labels = [optionLabel1, optionLabel2, optionLabel3, optionLabel4]
        
        for i in 0..<labels.count {
            if i < answers.count {
                labels[i]!.text = answers[i]
                labels[i]!.isHidden = false
                answerButtons[i].isHidden = false
            } else {
                labels[i]!.isHidden = true
                answerButtons[i].isHidden = true
            }
        }
        
        // Rest of the method remains the same
        updateAnswerButtonsSelection()
        
        previousButton.isEnabled = index > 0
        nextButton.isEnabled = true
        
        let progress = Float(index) / Float(max(1, QuestionBank.shared.questions.count - 1))
        progressView.progress = progress
    }
    
    func updateAnswerButtonsSelection() {
        // Reset all buttons to unselected state
        for button in answerButtons {
            button.backgroundColor = .white
        }
        
        // If user has selected an answer for this question, highlight it
        if let selectedIndex = userAnswers[currentQuestionIndex],
           selectedIndex < answerButtons.count {
            answerButtons[selectedIndex].backgroundColor = .systemBlue
        }
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        guard let buttonIndex = answerButtons.firstIndex(of: sender) else { return }
        
        // Store the user's answer
        userAnswers[currentQuestionIndex] = buttonIndex
        
        // Update the UI to show the selected answer
        updateAnswerButtonsSelection()
    }
    
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
            loadQuestion(at: currentQuestionIndex)
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if currentQuestionIndex < QuestionBank.shared.questions.count - 1 {
            currentQuestionIndex += 1
            loadQuestion(at: currentQuestionIndex)
        } else {
            // We're at the last question, show results
            performSegue(withIdentifier: "showResultsSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResultsSegue" {
            if let resultsVC = segue.destination as? ResultsViewController {
                // Calculate the score
                var correctCount = 0
                
                for (index, userAnswerIndex) in userAnswers.enumerated() {
                    if let userAnswerIndex = userAnswerIndex {
                        let question = QuestionBank.shared.questions[index]
                        let userSelectedAnswer = shuffledAnswers[index][userAnswerIndex]
                        
                        if userSelectedAnswer == question.correctAnswer {
                            correctCount += 1
                        }
                    }
                }
                
                resultsVC.correctAnswers = correctCount
                resultsVC.totalQuestions = QuestionBank.shared.questions.count
            }
        }
    }
}

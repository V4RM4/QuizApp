//
//  QuestionBankViewController.swift
//  QuizApp
//
//  Created by Vaisakh Suresh on 2025-03-28.
//

import UIKit
class QuestionBankViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Set the title
        title = "Question Bank"
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showQuestionBuilderSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuestionBuilderSegue" {
            if let questionBuilderVC = segue.destination as? QuestionBuilderViewController {
                questionBuilderVC.delegate = self
                
                // If we're editing an existing question
                if let indexPath = sender as? IndexPath {
                    let question = QuestionBank.shared.questions[indexPath.row]
                    questionBuilderVC.questionToEdit = question
                    questionBuilderVC.editingIndex = indexPath.row
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension QuestionBankViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionBank.shared.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
        
        let question = QuestionBank.shared.questions[indexPath.row]
        
        // Configure the cell
        var content = cell.defaultContentConfiguration()
        content.text = question.questionText
        
        let incorrectAnswersText = question.incorrectAnswers.joined(separator: ", ")
        content.secondaryText = "Correct: \(question.correctAnswer)\nIncorrect: \(incorrectAnswersText)"
        content.secondaryTextProperties.numberOfLines = 0
        
        cell.contentConfiguration = content
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension QuestionBankViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showQuestionBuilderSegue", sender: indexPath)
    }
}

// MARK: - QuestionBuilderDelegate
extension QuestionBankViewController: QuestionBuilderDelegate {
    func didAddQuestion(_ question: Question) {
        QuestionBank.shared.addQuestion(question)
        tableView.reloadData()
    }
    
    func didUpdateQuestion(at index: Int, with question: Question) {
        QuestionBank.shared.updateQuestion(at: index, with: question)
        tableView.reloadData()
    }
}

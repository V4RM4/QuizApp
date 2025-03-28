//
//  MainViewController.swift
//  QuizApp
//
//  Created by Vaisakh Suresh on 2025-03-28.
//

import UIKit
class MainViewController: UIViewController {
    
    @IBOutlet weak var startQuizButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startQuizSegue" {
            if let quizVC = segue.destination as? QuizViewController {
                // No need to pass the question bank as we're using a singleton
            }
        }
    }
    
    @IBAction func buildQuestionBankTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showQuestionBankSegue", sender: nil)
    }
    
    @IBAction func startQuizTapped(_ sender: UIButton) {
        if QuestionBank.shared.isEmpty() {
            let alert = UIAlertController(
                title: "Empty Question Bank",
                message: "Please add questions before starting the quiz.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            performSegue(withIdentifier: "startQuizSegue", sender: nil)
        }
    }
}

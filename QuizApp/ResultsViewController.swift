//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Vaisakh Suresh on 2025-03-28.
//

import UIKit
class ResultsViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var correctAnswers = 0
    var totalQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calculate and display the score
        let percentage = (Double(correctAnswers) / Double(totalQuestions)) * 100
        resultLabel.text = "Score: \(correctAnswers) / \(totalQuestions) (\(Int(percentage))%)"
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        // Navigate back to the main screen
        navigationController?.popToRootViewController(animated: true)
    }
}

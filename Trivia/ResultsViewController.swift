//
//  ResultsViewController.swift
//  Trivia
//
//  Created by Wytze Dijkstra on 13/12/2018.
//  Copyright © 2018 Wytze Dijkstra. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var highscoreNameTextField: UITextField!
    @IBAction func postScoreButtonPressed(_ sender: UIButton) {
        putScoreInList()
        performSegue(withIdentifier: "HighscoreSegue", sender: nil)
    }
    @IBOutlet weak var postScoreLabel: UIButton!
    @IBOutlet weak var takeAnotherQuizLabel: UIButton!
    
    
    
    var questions : [QuizItem]?
    var correctanswers : Int?
    var totalquestions : Int?
    var highscorename : String?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        takeAnotherQuizLabel.layer.cornerRadius = 15.0
        postScoreLabel.layer.cornerRadius = 15.0
        navigationItem.hidesBackButton = true
        resultsLabel.text = "You've got \(correctanswers!) correct answers from \(totalquestions!) questions! This gives you a score of \(calculateScore(with: questions!))% Submit you're score to the leaderboards below!"
    }
    
    func calculateScore(with questions : [QuizItem]) -> String {
        let score : Double = Double(correctanswers!) /  Double(questions.count) * 100.0
        return String(round(score))
    }
    
    func putScoreInList () {
        let url = URL(string: "https://ide50-wytzz.cs50.io:8080/list")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        highscorename = highscoreNameTextField.text!
        let postString = "name=\(highscorename!)&score=\(calculateScore(with: questions!))"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HighscoreSegue" {
            _ = segue.destination as! HighscoreTableViewController
        }
    }
    
}

//
//  QuestionViewController.swift
//  Trivia
//
//  Created by Wytze Dijkstra on 13/12/2018.
//  Copyright © 2018 Wytze Dijkstra. All rights reserved.
//

import UIKit
import HTMLString


class QuestionViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var booleanStackView: UIStackView!
    @IBOutlet weak var questionStackView: UIStackView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    
    var questions : [QuizItem] = []
    var correctanswers = 0
    var QuestionIndex = 0
    var newurl : String?
    
    @IBAction func answerButton1Pressed(_ sender: UIButton) {
        if answerButton1.currentTitle == questions[QuestionIndex].correct_answer { // checks if selected answer is right
            correctanswers += 1 // counts correct answers
            nextQuestion()
        } else {
            nextQuestion()
        }
    }
    @IBAction func answerButton2Pressed(_ sender: UIButton) {
        if answerButton2.currentTitle == questions[QuestionIndex].correct_answer {
            correctanswers += 1
            nextQuestion()
        } else {
            nextQuestion()
        }
    }
    @IBAction func answerButton3Pressed(_ sender: UIButton) {
        if answerButton3.currentTitle == questions[QuestionIndex].correct_answer {
            correctanswers += 1
            nextQuestion()
        } else {
            nextQuestion()
        }
    }
    @IBAction func answerButton4Pressed(_ sender: UIButton) {
        if answerButton4.currentTitle == questions[QuestionIndex].correct_answer {
            correctanswers += 1
            nextQuestion()
        } else {
            nextQuestion()
        }
    }
 
    @IBAction func trueButtonPressed(_ sender: UIButton) {
        if trueButton.currentTitle == questions[QuestionIndex].correct_answer {
            correctanswers += 1
            nextQuestion()
        } else {
            nextQuestion()
        }
    }

    @IBAction func falseButtonPressed(_ sender: UIButton) {
        if falseButton.currentTitle == questions[QuestionIndex].correct_answer {
            correctanswers += 1
            nextQuestion()
        } else {
            nextQuestion()
        }
    }
    func nextQuestion() {
        QuestionIndex += 1
        if QuestionIndex < questions.count {
            updateUI(with: questions)
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    func updateUI(with questions: [QuizItem]) {
        DispatchQueue.main.async {
            self.questionStackView.isHidden = true
            self.booleanStackView.isHidden = true
            self.questions = questions
            let currentquestion = questions[self.QuestionIndex]
            self.questionLabel.text = currentquestion.question.removingHTMLEntities // shows question
            self.navigationItem.title = "Question \(self.QuestionIndex + 1) of \(questions.count)" // shows the progress in questions
            if questions[self.QuestionIndex].type == "multiple" {//when the question is multiple choice
                self.questionStackView.isHidden = false
                var answers : [String] = currentquestion.incorrect_answers
                answers.append(currentquestion.correct_answer)
                //randomizes the list of all the answers, so the last option won't be the correct answer again and again
                var shuffled = [String]();
                for _ in 0..<answers.count
                {
                    let rand = Int(arc4random_uniform(UInt32(answers.count)))
                    
                    shuffled.append(answers[rand])
                    
                    answers.remove(at: rand)
                }
                self.updateAnswerButtons(with: shuffled)
            } else {
                self.booleanStackView.isHidden = false
            }
    }
    }
    
    func updateAnswerButtons(with answer: [String]) {
        answerButton1.setTitle(answer[0].removingHTMLEntities, for: .normal)
        answerButton2.setTitle(answer[1].removingHTMLEntities, for: .normal)
        answerButton3.setTitle(answer[2].removingHTMLEntities, for: .normal)
        answerButton4.setTitle(answer[3].removingHTMLEntities, for: .normal)
    }

    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        //get questions from url
        QuizController.shared.fetchQuestions(url: newurl!) { (questions) in
            if let questions = questions {
                self.updateUI(with: questions)
            }
        }
        //edit buttons
        answerButton1.layer.cornerRadius = 15.0
        answerButton2.layer.cornerRadius = 15.0
        answerButton3.layer.cornerRadius = 15.0
        answerButton4.layer.cornerRadius = 15.0
        trueButton.layer.cornerRadius = 15.0
        falseButton.layer.cornerRadius = 15.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.questions = questions
            resultsViewController.correctanswers = correctanswers
            resultsViewController.totalquestions = QuestionIndex
        }
    }
}

//
//  IntroductionViewController.swift
//  
//
//  Created by Wytze Dijkstra on 14/12/2018.
//

import UIKit

class IntroductionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var sliderLabel: UILabel!
    @IBAction func numberOfQuestionsSlider(_ sender: UISlider) {
        sliderLabel.text = String(Int(sender.value))
    }
    @IBAction func startButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "QuestionSegue", sender: nil)
        
    }
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    @IBOutlet weak var difficultySegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var numberOfQuestionsSlider: UISlider!
    
    var selectedCategory = 0
    var category = 0
    var categories: [String] = []
    var questions : [QuizItem] = []
    
    func makeURL(with url: String) -> String {
        var newurl = url
        if selectedCategory != 0 {
            category = selectedCategory + 8
            newurl.append("category=\(category)")
            if numberOfQuestionsSlider.value != 0 {
                newurl.append("&amount=\(Int(numberOfQuestionsSlider.value))")
                if difficultySegmentedControl.selectedSegmentIndex != 3 {
                    switch difficultySegmentedControl.selectedSegmentIndex {
                    case 0:
                        newurl.append("&difficulty=easy")
                    case 1:
                        newurl.append("&difficulty=medium")
                    case 2:
                        newurl.append("&difficulty=hard")
                    default:
                        break
                    }
                    if typeSegmentedControl.selectedSegmentIndex != 2 {
                        switch typeSegmentedControl.selectedSegmentIndex {
                        case 0:
                            newurl.append("&type=multiple")
                        case 1:
                            newurl.append("&type=boolean")
                        default:
                            break
                    }
                    }
                }
            }
        } else { //let "any category work"
            if numberOfQuestionsSlider.value != 0 {
                newurl.append("&amount=\(Int(numberOfQuestionsSlider.value))")
                if difficultySegmentedControl.selectedSegmentIndex != 3 {
                    switch difficultySegmentedControl.selectedSegmentIndex {
                    case 0:
                        newurl.append("&difficulty=easy")
                    case 1:
                        newurl.append("&difficulty=medium")
                    case 2:
                        newurl.append("&difficulty=hard")
                    default:
                        break
                    }
                    if typeSegmentedControl.selectedSegmentIndex != 2 {
                        switch typeSegmentedControl.selectedSegmentIndex {
                        case 0:
                            newurl.append("&type=multiple")
                        case 1:
                            newurl.append("&type=boolean")
                        default:
                            break
                        }
                    }
                }
            }
        }
        return newurl
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = row
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = ["Any Category", "General Knowledge", "Entertainment: Books", "Entertainment: Film", "Entertainment: Music", "Entertainment: Musicals & Theatres", "Entertainment: Television", "Entertainment: Video Games", "Entertainment: Board Games", "Science & Nature", "Science: Computers", "Science: Mathematics", "Mythology", "Sports", "Geography", "History", "Politics", "Art", "Celebrities", "Animals", "Vehicles", "Entertainment: Comics", "Science: Gadgets", "Entertainment: Japanese Anime & Manga", "Entertainment: Cartoon & Animations"]
    }
        
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "QuestionSegue" {
            let questionViewController = segue.destination as! QuestionViewController
            questionViewController.newurl = makeURL(with: "https://opentdb.com/api.php?") // full url
        }
    }
    
    @IBAction func unwindToIntroduction(segue: UIStoryboardSegue) {
    } // When you press the take another quiz button it will return to the first page
    
}

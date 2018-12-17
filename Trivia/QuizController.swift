//
//  QuizController.swift
//  Trivia
//
//  Created by Wytze Dijkstra on 11/12/2018.
//  Copyright © 2018 Wytze Dijkstra. All rights reserved.
//

import Foundation
import UIKit
import HTMLString

class QuizController {
    static let shared = QuizController()
    
   
    func fetchQuestions(url: String, completion: @escaping ([QuizItem]?) -> Void) {
        let baseURL = URL(string: url)!
        let task = URLSession.shared.dataTask(with: baseURL) { data, response, error in
            if let data = data, let quizItems = try? JSONDecoder().decode(QuizItems.self, from: data) {
                completion(quizItems.items)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchHighscores(completion: @escaping ([Playerscore]?) -> Void) {
        let urlHighScores = URL(string: "https://ide50-wytzz.cs50.io:8080/list")!
        let task = URLSession.shared.dataTask(with: urlHighScores) { (data, response, error) in
            do {
                if let data = data {
                    let highScores = try JSONDecoder().decode([Playerscore].self, from: data)
                    completion(highScores)
                } else {
                    completion(nil)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }


}

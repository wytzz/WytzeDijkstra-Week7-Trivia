//
//  QuizItem.swift
//  Trivia
//
//  Created by Wytze Dijkstra on 11/12/2018.
//  Copyright © 2018 Wytze Dijkstra. All rights reserved.
//

import Foundation

struct QuizItem: Decodable {
    var correct_answer: String
    var difficulty: String
    var question : String
    var category: String
    var type: String
    var incorrect_answers: [String]

    
}

struct QuizItems: Decodable {
    let responseCode: Int
    let items: [QuizItem]
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case items = "results"
    }
}

struct Playerscore: Codable {
    var id: Int
    var name: String
    var score: String
    
    init(json: [String: Any]) {
        id = json["id"] as? Int ?? -1
        name = json["name"] as? String ?? ""
        score = json["score"] as? String ?? ""
    }
}

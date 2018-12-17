//
//  HighscoreTableViewController.swift
//  Trivia
//
//  Created by Wytze Dijkstra on 17/12/2018.
//  Copyright © 2018 Wytze Dijkstra. All rights reserved.
//

import UIKit

class HighscoreTableViewController: UITableViewController {

    var highScores : [Playerscore] = []
    var newName: String = ""


    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        //get highscore json
        QuizController.shared.fetchHighscores() { (highScores) in
            if let highScores = highScores {
                self.updateUI(with: highScores)
            }
        }
    }
    
    func updateUI(with highScores: [Playerscore]) {
        DispatchQueue.main.async {
            self.highScores = highScores.sorted{
                //put higscores in order
                Double($1.score)! < Double($0.score)!
            }
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Highscore", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let player = highScores[indexPath.row]
        cell.textLabel?.text = player.name
        cell.detailTextLabel?.text = "\(Double(player.score)!)%"
        //makes the last submit bold
        if player.id == highScores.count {
            cell.textLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
            cell.detailTextLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        }
        
    }

}

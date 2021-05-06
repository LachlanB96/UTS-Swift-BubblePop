//
//  HighScoreViewController.swift
//  1-Navigation Controller
//
//  Created by Hua Zuo on 7/4/21.
//

import UIKit

class HighScoreViewController: UIViewController {

    @IBOutlet weak var highscoreTableView: UITableView!
    
    var highscores: [[String]] = [[]]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        highscoreTableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        highscoreTableView.delegate = self
        highscoreTableView.dataSource = self
        if let highscores =  UserDefaults.standard.value(forKey: "highscores") as? [[String]] {
            self.highscores = sortScores(highscores: highscores)
        }
    }
    
    // https://stackoverflow.com/a/39756583
    func sortScores(highscores: [[String]]) -> [[String]] {
        if(highscores.count > 1) {
            return highscores.sorted(by: { Float($0[1])! > Float($1[1])! })
        }
        return highscores
    }
    
    @IBAction func mainMenuButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension HighScoreViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highscores.count
    }
}

extension HighScoreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("The row is tapped")
        print("\(highscores[indexPath.row][1])")
        print(type(of: highscores[indexPath.row][1]))
        UserDefaults.standard.set([[]], forKey: "highscores")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = highscoreTableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        customCell.nameLabel.text = highscores[indexPath.row][0]
        customCell.scoreLabel.text = ("Score: \(highscores[indexPath.row][1])")
        let username = UserDefaults.standard.value(forKey: "username") as! String
        //Highlights your usernames highscores
        if(String(highscores[indexPath.row][0]) == username) {
            customCell.backgroundColor = .systemRed
        } else {
            customCell.backgroundColor = .blue
        }
        
        return customCell
    }
}

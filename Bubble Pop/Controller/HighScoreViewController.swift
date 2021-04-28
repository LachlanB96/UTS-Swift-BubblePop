//
//  HighScoreViewController.swift
//  1-Navigation Controller
//
//  Created by Hua Zuo on 7/4/21.
//

import UIKit

class HighScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var highscoreTableView: UITableView!
    var highscores: [[String]] = [[]]
    
    let names: [String] = ["123", "456"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highscoreTableView.delegate = self
        highscoreTableView.dataSource = self
        
        
        if let highscores =  UserDefaults.standard.value(forKey: "highscores") as? [[String]] {
            self.highscores = highscores
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("The row is tapped")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of scores: \(highscores.count)")
        print(highscores)
        return highscores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = highscoreTableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        print(indexPath)
        customCell.textLabel?.text = ("Name: \(highscores[indexPath.row][0]). Score: \(highscores[indexPath.row][1]).")
        customCell.backgroundColor = .blue
        return customCell
    }
    

    @IBAction func returnMainPage(_ sender: UIButton) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}

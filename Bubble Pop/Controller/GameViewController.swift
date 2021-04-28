//
//  GameViewController.swift
//  1-Navigation Controller
//
//  Created by Hua Zuo on 7/4/21.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    var name: String?
    var remainingTime = 60.0
    var timer = Timer()
    var score = 0
    
    
    
    var bubbleFactory = BubbleFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scoreLabel.text = String(score)
        nameLabel.text = name
        remainingTimeLabel.text = String(remainingTime)
        
        
        
        // active timer, and generate bubble each second
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {
            timer in
            self.generateBubble()
            self.bubbleFactory.tick()
            self.counting()
        }
        
    }
    
    @objc func counting() {
        remainingTime -= 0.1
        
        
        if remainingTime < 0 {
            print("Game OVER")
            //var highscores: [[String]]
            if var highscores = UserDefaults.standard.value(forKey: "highscores") as? [[String]] {
                print("Normal: \(bubbleFactory.score). String: \(String(bubbleFactory.score)).")
                highscores.append([String(name ?? "No Name"), String(bubbleFactory.score)])
                UserDefaults.standard.set(highscores, forKey: "highscores")
            } else {
                let highscore = [[String(name ?? "No Name"), String(bubbleFactory.score)]]
                UserDefaults.standard.set(highscore, forKey: "highscores")
            }
            
            if let item =  UserDefaults.standard.value(forKey: "highscores") as? [[String]] {
                print(item)
            }

            timer.invalidate()
            
            // show HighScore Screen
            let vc = storyboard?.instantiateViewController(identifier: "HighScoreViewController") as! HighScoreViewController
            self.navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.setHidesBackButton(true, animated: true)
            
            
            
        }
        remainingTimeLabel.text = String(remainingTime)
        scoreLabel.text = String(bubbleFactory.score)
        
    }
    
    @objc func generateBubble() {
        bubbleFactory.addBubble(view: self.view)

    }

}

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
        remainingTimeLabel.text = String(remainingTime)
        scoreLabel.text = String(bubbleFactory.score)
        
        if remainingTime == 0 {
            timer.invalidate()
            
            // show HighScore Screen
            let vc = storyboard?.instantiateViewController(identifier: "HighScoreViewController") as! HighScoreViewController
            self.navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.setHidesBackButton(true, animated: true)
            
            
            
        }
    }
    
    @objc func generateBubble() {
        //let colour = UIColor.init()
        
        let bubble = Bubble();
        bubbleFactory.addBubble(newBubble: bubble, view: self.view)
//
        //bubble.animation()
        //bubble.addTarget(self, action: #selector(bubblePressed), for: .touchUpInside)
        //self.view.addSubview(bubble)
    }

}

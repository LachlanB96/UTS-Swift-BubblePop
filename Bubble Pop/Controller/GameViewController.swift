import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var countDownLabel: UILabel!
    
    var name: String?
    let gameStartTime: Double = 60
    var remainingTime: Double = 60
    var startTimer = Timer()
    var gameTimer = Timer()
    var score = 0
    var countDownTimer: Int = 3
    
    let gameTimeInterval: Double = 0.1
    
    var bubbleFactory = BubbleFactory()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        scoreLabel.text = String(score)
        nameLabel.text = name
        countDownLabel.text = String(countDownTimer)
        //Convert time to Int so we round the number before stringifying
        remainingTimeLabel.text = ("Time: \(Int(remainingTime))")
        var playersHighscore: [String] = []
        if var highscores =  UserDefaults.standard.value(forKey: "highscores") as? [[String]] {
            highscores = highscores.sorted(by: { Float($0[1])! > Float($1[1])! })
            playersHighscore = highscores.first(where: { $0[0] == name }) ?? ["", "0"]
        } else {
            playersHighscore = ["", "0"]
        }
        highscoreLabel.text = ("HS: \(playersHighscore[1])")
        
        startTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            
            self.countDownLabel.text = String(self.countDownTimer)
            self.flash(element: self.countDownLabel)
            if(self.countDownTimer == 0){
                self.startTimer.invalidate()
                self.countDownLabel.isHidden = true
                self.startGameTimer()
            }
            self.countDownTimer -= 1
        }
    }
    
    func startGameTimer(){
        gameTimer = Timer.scheduledTimer(withTimeInterval: gameTimeInterval, repeats: true) {
            timer in
            self.generateBubble()
            self.bubbleFactory.tick(gameTime: self.gameStartTime, gameRemainingTime: self.remainingTime)
            self.counting()
        }
    }
    
    @objc func counting() {
        remainingTime -= gameTimeInterval
        //We check if there is < 500ms left, if so, invalidate timer
        //500ms is chosen as it gives a more natural rhythm to the countdown timer
        if remainingTime < 0.5 {
            if var highscores = UserDefaults.standard.value(forKey: "highscores") as? [[String]] {
                highscores.append([String(name ?? "No Name"), String(bubbleFactory.score)])
                UserDefaults.standard.set(highscores, forKey: "highscores")
            } else {
                let highscore = [[String(name ?? "No Name"), String(bubbleFactory.score)]]
                UserDefaults.standard.set(highscore, forKey: "highscores")
            }
            gameTimer.invalidate()
            // show HighScore Screen
            let vc = storyboard?.instantiateViewController(identifier: "HighScoreViewController") as! HighScoreViewController
            self.navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.setHidesBackButton(true, animated: true)
        }
        //Convert time to Int so we round the number before stringifying
        remainingTimeLabel.text = ("Time: \(Int(remainingTime))")
        scoreLabel.text = ("Score: \(bubbleFactory.score)")
    }
    
    @objc func generateBubble() {
        bubbleFactory.addBubble(view: self.view)
    }
    
    func flash(element: UIView) {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 1
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        element.layer.add(flash, forKey: nil)
    }

}

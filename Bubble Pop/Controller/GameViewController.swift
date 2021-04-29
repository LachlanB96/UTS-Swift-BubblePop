import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
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
        //Convert time to Int so we round the number before stringifying
        remainingTimeLabel.text = String(Int(remainingTime))
        var playersHighscore: [String] = []
        if var highscores =  UserDefaults.standard.value(forKey: "highscores") as? [[String]] {
            print(highscores)
            highscores = highscores.sorted(by: { Float($0[1])! > Float($1[1])! })
            print(highscores)
            playersHighscore = highscores.first(where: { $0[0] == "leach" }) ?? ["", "0"]
            print(playersHighscore)
        } else {
            playersHighscore = ["", "0"]
        }
        print(playersHighscore)
        highscoreLabel.text = playersHighscore[1]
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
            timer.invalidate()
            // show HighScore Screen
            let vc = storyboard?.instantiateViewController(identifier: "HighScoreViewController") as! HighScoreViewController
            self.navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.setHidesBackButton(true, animated: true)
        }
        //Convert time to Int so we round the number before stringifying
        remainingTimeLabel.text = String(Int(remainingTime))
        scoreLabel.text = String(bubbleFactory.score)
    }
    
    @objc func generateBubble() {
        bubbleFactory.addBubble(view: self.view)
    }

}

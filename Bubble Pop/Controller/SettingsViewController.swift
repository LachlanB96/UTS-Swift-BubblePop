import UIKit

class SettingsViewController: UIViewController {
    
    var maximumBubbleLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        positionUI()
    }
    
    @IBAction func deleteSettingsButtonPressed(_ sender: Any) {
        UserDefaults.standard.set([], forKey: "highscores")
    }
    
    @IBAction func consoleLogButtonPressed(_ sender: Any) {
        if let highscores =  UserDefaults.standard.value(forKey: "highscores") as? [[String]] {
            print("Highscores: \(highscores)")
        }
    }
    
    func positionUI(){
        let slider = UISlider(frame: CGRect(x: 10, y: 100, width: 200, height: 20))
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        self.view.addSubview(slider)
        slider.center.x = self.view.center.x
        slider.center.y = 400
        maximumBubbleLabel = UILabel(frame: CGRect(x: 10, y: 100, width: 200, height: 20))
        maximumBubbleLabel!.text = "Maximum Bubbles: \(slider.value)"
        self.view.addSubview(maximumBubbleLabel!)
        maximumBubbleLabel!.center.x = self.view.center.x
        maximumBubbleLabel!.center.y = 375
    }
    
    @objc func sliderValueDidChange(_ sender:UISlider!)
    {
        let sliderValue = Int(sender.value)
        UserDefaults.standard.set(sliderValue, forKey: "maxBubbles")
        maximumBubbleLabel!.text = "Maximum Bubbles: \(sliderValue)"
    }
}

import UIKit

//This view is the main menu, the player can enter three other views from here
//The highscore view, the game settings view, and the app settings view
class ViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var highscoreButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


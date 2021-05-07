import UIKit

//In this view the user can change the settings for the game they are about to play
class GameSettingViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timeSlider: UISlider!
    
    
    let gameDefaultTime: Float = 60
    
    //When we load this view, we set the labels and sliders values to what we expect
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing));
        view.addGestureRecognizer(tap)
        let name = UserDefaults.standard.value(forKey: "username")
        nameTextField.text = name as? String
        timeSlider.value = gameDefaultTime
    }
    
    //A segue into the game which passes the users username
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame" {
            let VC = segue.destination as! GameViewController
            UserDefaults.standard.set(nameTextField.text!, forKey: "username")
            VC.name = nameTextField.text!
            VC.remainingTime = Double(timeSlider.value)
        }
    }
}

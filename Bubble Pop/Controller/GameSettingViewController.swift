//
//  BlueViewController.swift
//  1-Navigation Controller
//
//  Created by Hua Zuo on 7/4/21.
//

import UIKit

class GameSettingViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timeSlider: UISlider!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing));
        view.addGestureRecognizer(tap)
        let name = UserDefaults.standard.value(forKey: "username")
        nameTextField.text = name as? String
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame" {
            let VC = segue.destination as! GameViewController
            UserDefaults.standard.set(nameTextField.text!, forKey: "username")
            VC.name = nameTextField.text!
            VC.remainingTime = Double(timeSlider.value)
        }
    }
  
}

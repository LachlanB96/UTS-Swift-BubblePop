//
//  SettingsViewController.swift
//  Bubble Pop
//
//  Created by administrator on 4/28/21.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteSettingsButtonPressed(_ sender: Any) {
        UserDefaults.standard.set([], forKey: "highscores")
    }
    
    @IBAction func consoleLogButtonPressed(_ sender: Any) {
        if let highscores =  UserDefaults.standard.value(forKey: "highscores") as? [[String]] {
            print("Highscores: \(highscores)")
        }
        //let appDeletegate = UIApplication.shared.delegate as! AppDelegate
        //print(appDeletegate.user.getName())
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

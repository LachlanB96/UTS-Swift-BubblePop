//
//  ViewController.swift
//  1-Navigation Controller
//
//  Created by Hua Zuo on 7/4/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var highscoreButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        // Do any additional setup after loading the view.
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //var user: User = appDelegate.createUserObject()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        print("rotated. width: \(UIScreen.main.bounds.width)")
        newGameButton.center.x = UIScreen.main.bounds.width / 2
    }


}


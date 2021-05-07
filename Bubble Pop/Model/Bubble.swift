//
//  Bubble.swift
//  1-Navigation Controller
//
//  Created by Hua Zuo on 7/4/21.
//

import UIKit


//Class bubble stores a UIButton with entended features
class Bubble: UIButton {
    
    var xPosition: Int = 0
    var yPosition: Int = 0
    var points: Int = 0
    var defaultLife : Float = 30.0
    var lifeRandomSurvival = Float.random(in: 70...130) / 100.0
    var lifeLeft : Int = 0
    var timer = Timer()
    var pressed: Bool = false
    var alive: Bool = true
    var bubbleSpeed: Double = 1 //The speed at which the bubble transitions off screen
    let minimumBubbleSpeed: Double = 0.2
    
    //The initialiser for the bubble, sets the bubbles position and size
    override init(frame: CGRect)  {
        super.init(frame: frame)
        self.xPosition = Int.random(in: 20...Int(UIScreen.main.bounds.width - 20))
        self.yPosition = Int.random(in: 20...Int(UIScreen.main.bounds.height - 20))
        self.backgroundColor = .red
        self.frame = CGRect(x: 60, y: 60, width: 40, height: 40)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
    }
    
    //A required INIT as bubble is a subclass of UIButton which requires this function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //A setup function to give the bubble its proper functions and to change its properties according to the bubble factory
    func setup(colour: String, points: Int){
        switch colour{
        case "red":
            self.backgroundColor = .systemRed
        case "pink":
            self.backgroundColor = .systemPink
        case "green":
            self.backgroundColor = .green
        case "blue":
            self.backgroundColor = .blue
        case "black":
            self.backgroundColor = .black
        default:
            self.backgroundColor = .purple
        }
        self.setTitle(String(points), for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        self.points = points
        self.tag = points
        self.lifeLeft = Int(defaultLife * lifeRandomSurvival)
    }
    
    //A function that is called for every event in the game, this tick is essentially a while loop while the bubble is alive
    func tick(gameTime: Double, gameRemainingTime: Double) -> String{
        bubbleSpeed = gameRemainingTime / gameTime + minimumBubbleSpeed
        lifeLeft -= 1
        if (lifeLeft < 0 && pressed){
            timer.invalidate()
            self.removeFromSuperview()
            alive = false
            return "death"
        } else if (lifeLeft < 0) {
            lifeLeft += 10 //Give time for moving animation
            self.animateOut()
            pressed = true
            alive = false
        }
        return "alive"
    }
    
    //An animation function where the bubble dies and flies off to the nearest side of the screen
    func animateOut() {
        UIView.animate(withDuration: bubbleSpeed) {
            //Get bounds of application
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height
            if(self.center.x < screenWidth / 2){ //Check if bubble is on left side of screen
                self.center.x = -40
            } else { //Else the bubble is on the right side of screen
                self.center.x = screenWidth + 40
            }
            //We take the range of -height to height (-700...700)
            let randomYOffet = Int.random(in: 0 ... Int(screenHeight))
            self.center.y = CGFloat(randomYOffet)
        }
    }
   
    //An animation function which produces a spring like effect to the UI object
    func animation() {
        let springAnimation = CASpringAnimation(keyPath: "transform.scale")
        springAnimation.duration = 0.6
        springAnimation.fromValue = 1
        springAnimation.toValue = 0.8
        springAnimation.repeatCount = 1
        springAnimation.initialVelocity = 0.5
        springAnimation.damping = 1
        layer.add(springAnimation, forKey: nil)
    }
    
    //An animation function to flash the UI object
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.2
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        layer.add(flash, forKey: nil)
    }
    
}

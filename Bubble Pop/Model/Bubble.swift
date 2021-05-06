//
//  Bubble.swift
//  1-Navigation Controller
//
//  Created by Hua Zuo on 7/4/21.
//

import UIKit

class Bubble: UIButton {
    
    let xPosition = Int.random(in: 20...400)
    let yPosition = Int.random(in: 20...800)
    var points: Int = 0
    var defaultLife : Float = 30.0
    var lifeRandomSurvival = Float.random(in: 70...130) / 100.0
    var lifeLeft : Int = 0
    var timer = Timer()
    var pressed: Bool = false
    var alive: Bool = true
    var bubbleSpeed: Double = 1 //The speed at which the bubble transitions off screen
    let minimumBubbleSpeed: Double = 0.2
    
    override init(frame: CGRect)  {
        super.init(frame: frame)
        self.backgroundColor = .red
        self.frame = CGRect(x: 60, y: 60, width: 40, height: 40)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        //timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){
        //    timer in
        //    self.tick()
        //}
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    
    func animateOut() {
//        let movement = CABasicAnimation(keyPath: "position")
//        movement.duration = 0.2
//        movement.fromValue = 1
//        movement.toValue = 0.8
//        movement.repeatCount = 1
//
//        layer.add(movement, forKey: nil)
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

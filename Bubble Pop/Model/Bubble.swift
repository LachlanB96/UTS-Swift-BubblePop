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
    
    func tick() -> String{
        lifeLeft -= 1
        if (lifeLeft < 0 && pressed){
            timer.invalidate()
            self.removeFromSuperview()
            return "death"
        } else if (lifeLeft < 0) {
            lifeLeft += 10 //Give time for moving animation
            print(lifeLeft)
            self.animateOut()
            pressed = true
        }
        return "alive"
    }
    
//    func setLifeLeft(lifeLeft: Int)
    
    func animateOut() {
//        let movement = CABasicAnimation(keyPath: "position")
//        movement.duration = 0.2
//        movement.fromValue = 1
//        movement.toValue = 0.8
//        movement.repeatCount = 1
//
//        layer.add(movement, forKey: nil)
        UIView.animate(withDuration: 0.5) {
            //Get bounds of application
            let width = 300
            let height = 700
            //We take the range of -width to width (-300...300)
            let randomXOffet = Int.random(in: (width * -1) / 2...width / 2)
            let randomYOffet = Int.random(in: (height * -1) / 2...height / 2)
            self.center.x += CGFloat(randomXOffet)
            self.center.y += CGFloat(randomYOffet)
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

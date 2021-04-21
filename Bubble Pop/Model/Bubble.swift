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
    var points = 0
    var lifeLeft = 30
    var timer = Timer()
    
    override init(frame: CGRect)  {
        super.init(frame: frame)
        self.backgroundColor = .red
        self.frame = CGRect(x: xPosition, y: yPosition, width: 50, height: 50)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){
            timer in
            self.tick()
        }
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

        self.points = points
        self.tag = points
    }
    
    func tick() -> String{
        lifeLeft -= 1
        if (lifeLeft < 0){
            timer.invalidate()
            self.removeFromSuperview()
            return "death"
        }
        return "alive"
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

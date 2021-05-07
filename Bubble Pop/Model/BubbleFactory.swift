//
//  BubbleFactory.swift
//  1-Navigation Controller
//
//  Created by administrator on 4/20/21.
//
import UIKit
import Foundation


//BubbleFactory is the intelligence behind spawning bubbles and keeping player score
class BubbleFactory{
    
    //A structure to keep track of the current combo
    struct combo {
        var lastTagPressed: Int;
        var onCombo: Float;
    }
    
    //Bubble spawn margins
    var leftMargin = 40
    var rightMargin = 40
    var topMargin = 150
    var bottomMargin = 40
    var maximumBubbles: Int
    var bubbleSpawnLength = 10
    var bubbleSpawnRandomiser: Float = 0.8
    var score: Float = 0;
    var bubbleArray: [Bubble];
    var comboKeeper = combo.init(lastTagPressed: 0, onCombo: 0)
    
    //Initialise the bubble factory with 15 bubbles or what the user defined in the settings
    init(){
        bubbleArray = []
        maximumBubbles = (UserDefaults.standard.value(forKey: "maxBubbles") ?? 15) as! Int
    }
    
    //For each repetition of the timer, tick() is called which then calls the bubbles own tick function.
    //This function is essentially the main loop of the game, checking if the bubble is alive and allowing it to tick
    func tick(gameTime: Double, gameRemainingTime: Double){
        for bubble in bubbleArray {
            let bubbleResponse = bubble.tick(gameTime: gameTime, gameRemainingTime: gameRemainingTime)
            if (bubbleResponse == "death"){
                bubbleArray.remove(at: bubbleArray.firstIndex(of: bubble) ??  0)
            }
        }
    }
    
    //A function that takes in two CGRects and tests to see if they are overlapping on a coordinate basis
    func collisionDetect(_ origin : CGRect, _ collider : CGRect) -> Bool {
        let distanceX = pow(origin.midX - collider.midX, 2)
        let distanceY = pow(origin.midY - collider.midY, 2)
        let distance = Int(Float(distanceX + distanceY).squareRoot())
        let objectCombinedWidth = Int((origin.width + collider.width)) / 2 //create distance that objects can be apart
        if (distance < objectCombinedWidth){
            return true
        } else {
            return false
        }
    }
    
    //If possible, this function is called to add a new bubble to the bubble factory
    func addBubble(view: UIView){
        if (bubbleArray.count < maximumBubbles){
            let newBubble = Bubble()
            let bubbleRandom = Int.random(in: 1...100)
            if (bubbleRandom < 40){
                newBubble.setup(colour: "red", points: 1)
            } else if (bubbleRandom < 70){
                newBubble.setup(colour: "pink", points: 2);
            } else if (bubbleRandom < 85) {
                newBubble.setup(colour: "green", points: 5)
            } else if (bubbleRandom < 95) {
                newBubble.setup(colour: "blue", points: 8)
            } else {
                newBubble.setup(colour: "black", points: 10)
            }
            var validPlacement = false
            var posX: Int = 0
            var posY: Int = 0
            while (!validPlacement){
                validPlacement = true
                posX = Int.random(in: leftMargin...400-rightMargin)
                posY = Int.random(in: topMargin...800-bottomMargin)
                for bubble in bubbleArray {
                    if (collisionDetect(bubble.frame, CGRect(x: posX, y: posY, width: 40, height: 40))) {
                        validPlacement = false
                    }
                }
            }
            newBubble.frame.origin = CGPoint.init(x: posX, y: posY)
            bubbleArray.append(newBubble)
            newBubble.animation()
            newBubble.addTarget(self, action: #selector(bubblePressed), for: .touchUpInside)
            view.addSubview(newBubble)
        }
    }
    

    //A function that is called when a bubble is pressed. If the bubble is alive and pressed, this function will execute
    @IBAction func bubblePressed(_ sender: Bubble){
        if(sender.alive){
            sender.backgroundColor = .black
            sender.lifeLeft = 10
            sender.flash()
            sender.pressed = true
            sender.removeTarget(self, action: #selector(bubblePressed), for: .touchUpInside)
            if (sender.tag == comboKeeper.lastTagPressed){
                comboKeeper.onCombo = 1
            } else {
                comboKeeper.onCombo = 0
            }
            comboKeeper.lastTagPressed = sender.tag
            score += Float(sender.tag) + (comboKeeper.onCombo * 0.5 * Float(sender.tag))
        }
    }
}

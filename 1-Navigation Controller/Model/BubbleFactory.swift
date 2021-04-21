//
//  BubbleFactory.swift
//  1-Navigation Controller
//
//  Created by administrator on 4/20/21.
//
import UIKit
import Foundation

class BubbleFactory{
    
    
    var maximumBubbles = 5000
    var bubbleSpawnLength = 5
    var bubbleSpawnRandomiser = 0.8
    
    var currentBubbleCount = 0;
    var score = 0;
    
    var bubbleArray: [Bubble];
    
    struct combo {
        var lastTagPressed: Int = 0;
        var currentCombo: Int = 0;
    }
    
    var comboKeeper = combo.init(lastTagPressed: 0, currentCombo: 0)
    
    
    init(){
        bubbleArray = []
    }
    
    func tick(){
        for bubble in bubbleArray {
            let bubbleResponse = bubble.tick()
            if (bubbleResponse == "death"){
                bubbleArray.remove(at: bubbleArray.index(of: bubble) ??  0)
            }
        }
    }
    
    func addBubble(newBubble: Bubble, view: UIView){
        if (bubbleArray.count < maximumBubbles){
            if (Int.random(in: 1...2) == 1){
                newBubble.setup(colour: "red", points: 2)
            } else {
                newBubble.setup(colour: "green", points: 1);
            }
            bubbleArray.append(newBubble)
            newBubble.animation()
            newBubble.addTarget(self, action: #selector(bubblePressed), for: .touchUpInside)
            view.addSubview(newBubble)
            
        }
    }
    
    @IBAction func bubblePressed(_ sender: UIButton){
        sender.removeFromSuperview()
        if (sender.tag == comboKeeper.lastTagPressed){
            comboKeeper.currentCombo += 1
        } else {
            comboKeeper.currentCombo = 0
        }
        comboKeeper.lastTagPressed = sender.tag
        score += Int(Double(sender.tag) * (Double(comboKeeper.currentCombo) * 1.5))        
    }
}

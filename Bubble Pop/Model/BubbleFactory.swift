//
//  BubbleFactory.swift
//  1-Navigation Controller
//
//  Created by administrator on 4/20/21.
//
import UIKit
import Foundation

class BubbleFactory{
    
    
    var maximumBubbles = 10
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
                print(bubbleArray.firstIndex(of: bubble))
                
                bubbleArray.remove(at: bubbleArray.index(of: bubble) ??  0)
            }
        }
    }
    
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
        score += Int(Double(sender.tag) + (Double(comboKeeper.currentCombo) * 1.5 * Double(sender.tag)))
    }
}

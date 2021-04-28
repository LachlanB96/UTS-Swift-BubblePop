//
//  User.swift
//  Bubble Pop
//
//  Created by administrator on 4/28/21.
//

import Foundation

class User {
    
    var name: String
    var highscore: String
    
    init() {
        self.name = "No Name"
        self.highscore = "2"
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func getName() -> String {
        return self.name
    }
}

//
//  UserModel.swift
//  MVVM Practice
//
//  Created by tokkislove on 3/18/25.
//

import Foundation

struct UserModel {
    var name: String
    var age: Int
    
    mutating func increaseAge() {
        self.age += 1
    }
    
    mutating func decreaseAge() {
        self.age -= 1
    }
}

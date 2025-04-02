//
//  UserModel.swift
//  UMC-iOS-WorkBook
//
//  Created by 곽은채 on 3/25/25.
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


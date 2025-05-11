//
//  UserViewModel.swift
//  UMC-iOS-WorkBook-3
//
//  Created by 곽은채 on 3/31/25.
//

import Foundation

@Observable
class UserViewModel {
    var users = [
        User(name: "Alice", age: 24),
        User(name: "Bob", age: 30),
        User(name: "Charlie", age: 28)
    ]
}

//
//  UserModel.swift
//  UMC-iOS-WorkBook-3
//
//  Created by 곽은채 on 3/31/25.
//

import Foundation

struct User: Identifiable {
    let id = UUID()
    var name: String
    var age: Int
}

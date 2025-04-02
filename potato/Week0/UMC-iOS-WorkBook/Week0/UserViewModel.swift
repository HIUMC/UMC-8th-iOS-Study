//
//  UserViewModel.swift
//  UMC-iOS-WorkBook
//
//  Created by 곽은채 on 3/25/25.
//

import Foundation

class UserViewModel1: ObservableObject {
    
    @Published var userModel: UserModel
    
    init(userModel: UserModel) {
        self.userModel = userModel
    }
    
    func increaseAge() {
        self.userModel.increaseAge()
    }
    
    func decreaseAge() {
        self.userModel.decreaseAge()
    }
}

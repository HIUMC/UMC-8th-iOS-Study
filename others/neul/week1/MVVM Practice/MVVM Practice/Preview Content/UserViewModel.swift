//
//  UserViewModel.swift
//  MVVM Practice
//
//  Created by tokkislove on 3/18/25.
//
import Foundation

class UserViewModel: ObservableObject {
    
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

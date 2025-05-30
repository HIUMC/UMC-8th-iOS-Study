//
//  SignupViewModel.swift
//  Starbucks_project
//
//  Created by Yoonseo on 3/26/25.
//

import Foundation
import SwiftUI


class SignupViewModel : ObservableObject {
    
    @AppStorage("name") var storedname: String = ""
    @AppStorage("email") var storedemail: String = ""
    @AppStorage("password") var storedpassword: String = ""
    
    @Published var name : String = ""
    @Published var email : String = ""
    @Published var password : String = ""
    
    func saveUserInfo() {
        storedname = name
        storedemail = email
        storedpassword = password
    }
    
}

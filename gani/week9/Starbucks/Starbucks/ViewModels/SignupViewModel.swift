//
//  SignupViewModel.swift
//  Starbucks
//
//  Created by 이가원 on 3/28/25.
//
import Foundation
import SwiftUI

@Observable
class SignupViewModel{
    var nickname: String = ""
    var email: String = ""
    var password: String = ""


    
    public func getSignupData() -> (String, String, String) {
        return (nickname, email, password)
    }

    
}

//
//  SignupViewModel.swift
////  Starbucks_Week1_gogo
////
////  Created by 고석현 on 4/1/25.
////
//
import Foundation
import Observation

@Observable
class SignupViewModel  {
    var nickname: String = ""
    var email: String = ""
    var password: String = ""
    
    
    public func getSignupData() -> (String, String, String) {
        return (nickname, email, password)
    }

}

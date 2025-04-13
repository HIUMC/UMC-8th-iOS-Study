//
//  SignupViewModel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 3/27/25.
//

import Observation
import SwiftUI

@Observable
class SignupViewModel {
    
    var newID: String = ""
    var email: String = ""
    var newPassword: String = ""

    
    public func saveUserInfo() {
        //print("사용자 정보 저장됨: \(newID), \(email), \(newPassword)")
    }
}

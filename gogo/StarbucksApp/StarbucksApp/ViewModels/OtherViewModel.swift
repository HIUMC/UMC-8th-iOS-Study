//
//  OtherVIewModel.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/3/25.
//

import Foundation
import SwiftUI
//옵져버블 매크로와 바인더블 이용해보자잇

//옵져버블 매크로 선언
//아디 비번 등은 영구 저장해야 하므로 AppStorage.
@Observable
class OtherViewModel {
    @ObservationIgnored
    @AppStorage("nickname") private var nickname : String = ""
    @ObservationIgnored
    @AppStorage("email") private var email : String = ""
    @ObservationIgnored
    @AppStorage("password") private var password : String = ""
    
    var signupModel: SignupModel = SignupModel(nickname: "", email: "", password:"")
    
    
    public func saveStorage(){
        self.nickname = signupModel.nickname
        self.email = signupModel.email
        self.password = signupModel.password
        print("AppStorage 에 저장됌.")       
        
    }
}

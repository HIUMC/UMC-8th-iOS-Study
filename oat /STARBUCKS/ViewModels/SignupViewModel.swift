//
//  SignupViewModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/26/25.
//

import Foundation
import SwiftUI

import SwiftUI

class SignupViewModel: ObservableObject {
    @AppStorage("nickname") var storedNickname: String = ""
    @AppStorage("email") var storedEmail: String = ""
    @AppStorage("pwd") var storedPwd: String = ""

    @Published var nickname: String = ""
    @Published var email: String = ""
    @Published var pwd: String = ""
    

}





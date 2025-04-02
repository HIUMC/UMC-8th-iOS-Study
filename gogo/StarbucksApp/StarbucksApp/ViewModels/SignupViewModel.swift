//
//  SignupViewModel.swift
////  Starbucks_Week1_gogo
////
////  Created by 고석현 on 4/1/25.
////
//
//import Foundation
//import SwiftUI
//
//class SignupViewModel: ObservableObject {
//    
//    @AppStorage("nickname") private var nickname : String = ""
//    @AppStorage("email") private var email : String = ""
//    @AppStorage("password") private var password : String = ""
//    
//   
//    
//    @Published var signupModel: SignupModel = .init(nickname: "", email: "", password: "")
//    
//    public func saveStorage(){
//        self.nickname = signupModel.nickname
//        self.email = signupModel.email
//        self.password = signupModel.password
//        print("AppStorage에 저장됌.")
//    }
//    
//}
//
//#Preview {
//    SignupView(viewModel: SignupViewModel())
//}

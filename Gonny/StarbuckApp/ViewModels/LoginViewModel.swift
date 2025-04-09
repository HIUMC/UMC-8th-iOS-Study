//
//  LoginViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/24/25.
//
import SwiftUI
import Observation

@Observable
class LoginViewModel{
    var id: String = ""
    var pwd: String = ""
    
    func isValid() -> Bool {
           // id와 pwd가 비어있지 않으면 로그인 성공
           return !id.isEmpty && !pwd.isEmpty
       }
}


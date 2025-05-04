
//
//  SighupViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/30/25.
//

import Foundation
import SwiftUI
import Observation


class SignupViewModel: ObservableObject { //매크로 쓰면 AppStorage 이게 안되는 것 같음 그니가 View에서 구현해야하니까 . 딴 사람들 다 이거 아 ㄴ썻서
    
    @Published var nickname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    //UserDefault 저장할 @AppStorage
    @AppStorage("nickname") private var savedNickname=""
    @AppStorage("email") private var savedEmail=""
    @AppStorage("password") private var savedPassword=""
    
    // 모델 객체 생성 함수 (저장은 하지 않음). 지피티한테 물어본 함수
    func SaveUser(){
        savedNickname=nickname
        savedEmail=email
        savedPassword=password
        
    }
    
    
}

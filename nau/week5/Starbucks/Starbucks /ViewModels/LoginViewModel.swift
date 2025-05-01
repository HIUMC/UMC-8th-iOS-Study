//
//  LoginViewModel.swift
//  Starbucks
//
//  Created by nau on 3/18/25.
//

import Foundation
import SwiftUI

@Observable
class LoginViewModel: ObservableObject {
    
    var model: LoginModel = .init()
   
    //computed property 
    var id: String {
        get { model.id }
        set { model.id = newValue }
    }
    
    var pwd: String {
        get { model.pwd }
        set { model.pwd = newValue }
    }
}

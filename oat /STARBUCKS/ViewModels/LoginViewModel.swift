//
//  LoginViewModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/25/25.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var pwd: String = "" 
}


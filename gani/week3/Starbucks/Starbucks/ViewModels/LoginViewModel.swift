//
//  LoginViewModel.swift
//  Starbucks
//
//  Created by 이가원 on 3/24/25.
//

import SwiftUI
import Foundation

class LoginViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var password: String = ""
}

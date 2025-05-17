//
//  LoginViewModel.swift
//  Starbucks_Week1_gogo
//
//  Created by 고석현 on 3/24/25.
//
//

import SwiftUI
import Foundation

class LoginViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var password: String = ""
}

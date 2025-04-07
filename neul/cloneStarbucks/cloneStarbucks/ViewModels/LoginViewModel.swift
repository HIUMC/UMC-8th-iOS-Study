//
//  LoginViewModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/22/25.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var pwd: String = ""
}

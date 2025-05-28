//
//  SignupViewModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/26/25.
//
import Foundation

class SignupViewModel: ObservableObject {
    @Published var nickname = ""
    @Published var email = ""
    @Published var pwd = ""

    private let keychain = KeychainService.shared
    private let service = "com.minjung.keychain.login"

    func saveToKeychain() -> Bool {
        let status = keychain.savePasswordToKeychain(account: email, service: service, password: pwd)
        return status == errSecSuccess
    }
}







//
//  KeychainHelper.swift
//  Starbucks
//
//  Created by 박정환 on 5/12/25.
//

import KeychainAccess

class KeychainHelper {
    private let keychain = Keychain(service: "com.yourAppName.service")
    
    // Keychain 저장
    func saveToKeychain(account: String, value: String) {
        do {
            try keychain.set(value, key: account)
        } catch {
            print("Keychain save error: \(error)")
        }
    }
    
    // Keychain으로부터 데이터 가져오기
    func getFromKeychain(account: String) -> String? {
        do {
            return try keychain.get(account)
        } catch {
            print("Keychain retrieve error: \(error)")
            return nil
        }
    }
    
    // Keychain 데이터 삭제
    func deleteFromKeychain(account: String) {
        do {
            try keychain.remove(account)
        } catch {
            print("Keychain delete error: \(error)")
        }
    }
}

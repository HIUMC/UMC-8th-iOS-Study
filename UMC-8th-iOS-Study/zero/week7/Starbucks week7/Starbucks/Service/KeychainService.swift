//
//  KeychainService.swift
//  Starbucks
//
//  Created by 김영택 on 5/11/25.
//

import Foundation
import Security

class KeychainService {
    static let shared = KeychainService()
    
    private init() {}

    private let account = "userCredential"
    private let service = "com.myApp.userCredential"

    @discardableResult
    private func saveCredential(_ credential: UserCredential) -> OSStatus {
        do {
            let data = try JSONEncoder().encode(credential)
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: account,
                kSecAttrService as String: service,
                kSecValueData as String: data,
                kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
            ]

            SecItemDelete(query as CFDictionary) // 중복 방지
            return SecItemAdd(query as CFDictionary, nil)
        } catch {
            print("Credential 인코딩 실패:", error)
            return errSecParam
        }
    }

    private func loadCredential() -> UserCredential? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess, let data = item as? Data else {
            print("Keychain 불러오기 실패:", status)
            return nil
        }

        do {
            return try JSONDecoder().decode(UserCredential.self, from: data)
        } catch {
            print("디코딩 실패:", error)
            return nil
        }
    }

    public func saveUser(userID: String, password: String) {
        let credential = UserCredential(userID: userID, password: password)
        let status = saveCredential(credential)

        if status == errSecSuccess {
            UserDefaults.standard.set(userID, forKey: "newID") // 닉네임 저장
            print("Keychain 저장 성공 + 닉네임 저장")
        } else {
            print("Keychain 저장 실패")
        }
    }


    public func loadUser() -> UserCredential? {
        return loadCredential()
    }
}

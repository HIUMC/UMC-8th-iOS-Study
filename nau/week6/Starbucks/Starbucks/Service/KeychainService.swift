//
//  KeyChain.swift
//  Starbucks
//
//  Created by nau on 5/8/25.
//
import Foundation
import Security

class KeychainService {
    static let shared = KeychainService()
    
    enum Key: String {
        case accessToken
        case refreshToken
        case id
        case pwd
    }
    
    private init() {}
    
    // MARK: - TokenInfo 저장
    func saveToken(_ token: TokenInfo) {
        save(value: token.accessToken, for: .accessToken)
        save(value: token.refreshToken, for: .refreshToken)
    }
    
    func loadToken() -> TokenInfo? {
        guard let access = load(for: .accessToken),
              let refresh = load(for: .refreshToken) else {
            return nil
        }
        
        return TokenInfo(accessToken: access, refreshToken: refresh)
    }
    
    func deleteToken() {
        delete(for: .accessToken)
        delete(for: .refreshToken)
    }
    
    // MARK: - ID & PWD 저장
    func saveCredential(id: String, password: String) {
        save(value: id, for: .id)
        save(value: password, for: .pwd)
    }
    
    func loadCredential() -> (id: String, password: String)? {
        guard let id = load(for: .id),
              let pwd = load(for: .pwd) else {
            return nil
        }
        return (id, pwd)
    }
    
    func deleteCredential() {
        delete(for: .id)
        delete(for: .pwd)
    }
    
    // MARK: - 공통 메서드
    @discardableResult
    private func save(value: String, for key: Key) -> OSStatus {
        guard let data = value.data(using: .utf8) else {
            return errSecParam
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    private func load(for key: Key) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess,
              let data = item as? Data,
              let result = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return result
    }
    
    @discardableResult
    private func delete(for key: Key) -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
        ]
        return SecItemDelete(query as CFDictionary)
    }
}


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
    
    private init() {}
    
    private let account = "authToken"
    private let service = "com.myKeychain.tokenInfo"
    
    @discardableResult
    private func saveTokenInfo(_ tokenInfo: TokenInfo) -> OSStatus {
        do {
            let data = try JSONEncoder().encode(tokenInfo)
            
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: account,
                kSecAttrService as String: service,
                kSecValueData as String: data,
                kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
            ]
            
            SecItemDelete(query as CFDictionary)
            
            return SecItemAdd(query as CFDictionary, nil)
        } catch {
            print("JSON 인코딩 실패:", error)
            return errSecParam
        }
    }
    
    private func loadTokenInfo() -> TokenInfo? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess,
              let data = item as? Data else {
            print("토큰 정보 불러오기 실패 - status:", status)
            return nil
        }
        
        do {
            return try JSONDecoder().decode(TokenInfo.self, from: data)
        } catch {
            print("❌ JSON 디코딩 실패:", error)
            return nil
        }
    }
    
    @discardableResult
    private func deleteTokenInfo() -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        
        return SecItemDelete(query as CFDictionary)
    }
    
    public func saveToken(_ tokenInfo: TokenInfo) {
        let saveStatus = self.saveTokenInfo(tokenInfo)
        print(saveStatus == errSecSuccess ? "저장 성공" : "저장 실패")
    }
    
    public func loadToken() {
        if let loadedToken = self.loadTokenInfo() {
            print("accessToken:", loadedToken.accessToken)
            print("RefreshToken:", loadedToken.refreshToken)
        } else {
            print("토큰 정보 없음")
        }
    }
    
    public func deleteToken() {
        let deleteStatus = self.deleteTokenInfo()
        print(deleteStatus == errSecSuccess ? "삭제 성공" : "삭제 실패")
    }
    
    private let credentialAccount = "userCredential"

    // 저장
    @discardableResult
    private func saveCredential(_ credential: SignupModel) -> OSStatus {
        do {
            let data = try JSONEncoder().encode(credential)
            
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: credentialAccount,
                kSecAttrService as String: service,
                kSecValueData as String: data,
                kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
            ]
            
            SecItemDelete(query as CFDictionary)
            return SecItemAdd(query as CFDictionary, nil)
        } catch {
            print("자격 정보 인코딩 실패:", error)
            return errSecParam
        }
    }

    // 불러오기
    private func loadCredential() -> SignupModel? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: credentialAccount,
            kSecAttrService as String: service,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess, let data = item as? Data else {
            print("자격 정보 불러오기 실패 - status:", status)
            return nil
        }
        
        return try? JSONDecoder().decode(SignupModel.self, from: data)
    }

    // 삭제
    @discardableResult
    private func deleteCredential() -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: credentialAccount,
            kSecAttrService as String: service
        ]
        
        return SecItemDelete(query as CFDictionary)
    }

    public func saveUserCredential(_ credential: SignupModel) {
        let status = saveCredential(credential)
        print(status == errSecSuccess ? "자격 저장 성공" : "자격 저장 실패")
    }

    public func loadUserCredential() -> SignupModel? {
        if let credential = loadCredential() {
            print("ID: \(credential.email), Password: \(credential.pwd)")
            return loadCredential()!
        } else {
            print("저장된 자격 없음")
            return nil
        }
    }

    public func deleteUserCredential() {
        let status = deleteCredential()
        print(status == errSecSuccess ? "자격 삭제 성공" : "자격 삭제 실패")
    }
}

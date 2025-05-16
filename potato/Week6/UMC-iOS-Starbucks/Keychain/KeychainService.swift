//
//  KeychainService.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 5/13/25.
//

import Foundation
import Security

class KeychainService {
    static let shared = KeychainService()
    
    // MARK: - user 관리
    
    // 사용자의 비밀번호 저장
    @discardableResult
    func saveUserInfo(email: String, userInfo: UserInfo) -> OSStatus {
        do {
            let data = try JSONEncoder().encode(userInfo) // 저장할 데이터
            
            // 2. Keychain Item 딕셔너리 구성
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: email,
                kSecAttrService as String: "com.myKeychain.userInfo",
                kSecValueData as String: data,
                kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
            ]
            
            SecItemDelete(query as CFDictionary) // 3. 이미 같은 항목이 있다면 삭제 (중복 방지)
            
            // 4. 새 항목 추가
            return SecItemAdd(query as CFDictionary, nil)
        } catch {
            print("JSON 인코딩 실패:", error)
            return errSecParam // 잘못된 데이터
        }
    }
    
    // 저장된 이메일 비밀번호 불러오기
    @discardableResult
    func loadUserInfo(email: String) -> UserInfo? {
        // 1. 검색 쿼리 구성
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecAttrService as String: "com.myKeychain.userInfo",
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef? // 2. 검색 결과 저장 변수
        let status = SecItemCopyMatching(query as CFDictionary, &item) // 3. Keychain에서 항목 검색
        
        // 4. 상태 확인 및 결과 처리
        guard status == errSecSuccess,
              let data = item as? Data else {
            print("토큰 정보 불러오기 실패 - status:", status)
            return nil
        }
        
        do {
            return try JSONDecoder().decode(UserInfo.self, from: data)
        } catch {
            print("❌ JSON 디코딩 실패:", error)
            return nil
        }
    }
    
    // 지정된 계정에 대한 항목 삭제
    @discardableResult
    func deleteUserInfo(email: String) -> OSStatus {
        // 1. 삭제할 항목을 식별할 쿼리 구성
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecAttrService as String: "com.myKeychain.userInfo"
        ]

        // 2. 항목 삭제 시도
        let status = SecItemDelete(query as CFDictionary)

        // 3. 상태 확인 및 로그 출력
        if status == errSecSuccess {
            print("Keychain 삭제 성공 - [\(service) : \(account)]")
        } else if status == errSecItemNotFound {
            print("Keychain 항목 없음 - [\(service) : \(account)]")
        } else {
            print("Keychain 삭제 실패 - status: \(status)")
        }

        return status
    }
    
    
    // MARK: - 토큰 관리
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
    
    // MARK: - 실제 사용하는 함수(user)
    public func saveUser(email: String, userInfo: UserInfo) {
        let saveStatus = self.saveUserInfo(email: email, userInfo: userInfo)
        print(saveStatus == errSecSuccess ? "회원 저장 성공" : "회원 저장 실패")
    }
    
    public func loadUser(email: String) {
        if let loadedUser = self.loadUserInfo(email: email) {
            print("password:", loadedUser.password)
            print("nickname:", loadedUser.nickname)
        } else {
            print("회원 정보 없음")
        }
    }
    
    public func deleteUser(email: String) {
        let deleteStatus = self.deleteUserInfo(email: email)
        print(deleteStatus == errSecSuccess ? "회원 삭제 성공" : "회원 삭제 실패")
    }
    
    // MARK: - 실제 사용하는 함수(token)
    public func saveToken(_ tokenInfo: TokenInfo) {
        let saveStatus = self.saveTokenInfo(tokenInfo)
        print(saveStatus == errSecSuccess ? "토큰 저장 성공" : "토큰 저장 실패")
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
        print(deleteStatus == errSecSuccess ? "토큰 삭제 성공" : "토큰 삭제 실패")
    }
}


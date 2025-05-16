import Foundation
import Security

// MARK: - Keychain을 이용한 로그인 정보 저장
class KeychainAccountService {
    
    static let shared = KeychainAccountService()
    
    // 저장할 항목 종류를 정의 (Key 값)
    enum Key: String {
        case nickname
        case email
        case password
        case token
    }
    /// 키체인에 문자열 저장. 기존 값이 있으면 삭제 후 새로 저장
    @discardableResult
    func save(value: String, for key: Key) -> OSStatus {
        guard let data = value.data(using: .utf8) else {
            return errSecParam
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        SecItemDelete(query as CFDictionary) // 기존 값 제거
        return SecItemAdd(query as CFDictionary, nil) // 새 값 추가
    }

    /// 키체인에서 문자열 불러오기
    func load(for key: Key) -> String? {
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

    /// 키체인에서 특정 키에 해당하는 값 삭제
    @discardableResult
    func delete(for key: Key) -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
        ]
        return SecItemDelete(query as CFDictionary)
    }

}

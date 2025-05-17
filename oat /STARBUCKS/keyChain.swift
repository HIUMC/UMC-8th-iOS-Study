//
//  keyChain.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/13/25.
//

import Foundation
import Security

class Keychain {
    static let shared = Keychain() // 싱클턴으로 구성
    private init() {}

    // 어떤 값을 특정 키에 저장하는 함수 (이메일, 비밀번호)
    func save(_ value: String, forKey key: String) {
        if let data = value.data(using: .utf8) {
            let query = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key, // 저장할 키
                kSecValueData: data // 실제 저장할 값
            ] as CFDictionary

            SecItemDelete(query) //기존에 같은 키가 있으면 삭제
            SecItemAdd(query, nil) // 새로 저장
        }
    }

    func read(forKey key: String) -> String? {
        //특정 키로 저장된 값을 불러오는 함수
        let query = [
            kSecClass: kSecClassGenericPassword, // 비밀번호 항목 찾기
            kSecAttrAccount: key, // 키에 해당하는 값
            kSecReturnData: true, // true: 값을 가져오기
            kSecMatchLimit: kSecMatchLimitOne // 여러개 있어도 하나의 키만 가져옴
        ] as CFDictionary

        var dataTypeRef: AnyObject? // 결과 값을 받을 함수
        
        if SecItemCopyMatching(query, &dataTypeRef) == noErr {
            //요청 성공
            if let data = dataTypeRef as? Data,
               let string = String(data: data, encoding: .utf8) {
                // 데이터를 문자열로 변환해서 반환
                return string
            }
        }
        return nil
    }

    func delete(forKey key: String) {
        //특정 키에 저장된 값을 삭제하는 함수
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ] as CFDictionary
        
        SecItemDelete(query) //삭제 실행
    }
}

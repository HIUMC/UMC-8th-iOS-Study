//
//  KeychainView.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/16/25.
//

import Foundation
import SwiftUI

struct KeychainView: View {
    
    let keychain = KeychainService.shared
    
    let account = "helloWorld"
    let service = "WorkBookTest"
    let password = "mySecurePassword"
    
    enum ButtonType: String, CaseIterable {
        case save = "저장하기"
        case load = "불러오기"
        case delete = "삭제하기"
    }
    
    var body: some View {
        VStack(spacing: 10, content: {
            ForEach(ButtonType.allCases, id: \.rawValue, content: { button in
                Button(action: {
                    handleAction(button)
                }, label: {
                    Text(button.rawValue)
                        .font(.title)
                })
            })
        })
    }
    
    func handleAction(_ type: ButtonType) {
        switch type {
        case .save:
            self.saveStatus()
        case .load:
            self.loadStatus()
        case .delete:
            self.deletedStatus()
        }
    }
    
    func saveStatus() {
        let saveStatus = keychain.savePasswordToKeychain(account: account, service: service, password: password)
        if saveStatus == errSecSuccess {
            print("비밀번호 저장 성공")
        } else {
            print("비밀번호 저장 실패:", saveStatus)
        }
    }
    
    func loadStatus() {
        if let retrievedPasswrod = keychain.load(account: account, service: service) {
            print("불러온 비밀번호:", retrievedPasswrod)
        } else {
            print("저장된 비밀번호 없음")
        }
    }
    
    func deletedStatus() {
        let deleteStatus = keychain.delete(account: account, service: service)
        if deleteStatus == errSecSuccess {
            print("비밀번호 삭제 완료")
        } else {
            print("비밀번호 삭제 실패:", deleteStatus)
        }
    }
}

#Preview {
    KeychainView()
}

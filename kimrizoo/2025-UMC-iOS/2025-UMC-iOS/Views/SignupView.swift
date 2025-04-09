//
//  SignupView.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 3/25/25.
//

import SwiftUI

struct SignupView: View {
    
    /// 변수 선언
    @State private var nickname = ""
    @State private var email = ""
    @State private var password = ""
    
    @FocusState private var focusField: Field?
    
    /// 포커스를 관리하는 FocusState Enum
    enum Field: Hashable {
        case nickname, email, password
    }
    
    var body: some View {
        VStack {
            VStack {
                CustomTextField(placeholder: "닉네임", text: $nickname)
                    .focused($focusField, equals: .nickname)
                
                Spacer().frame(height: 49)
                
                CustomTextField(placeholder: "이메일", text: $email)
                    .focused($focusField, equals: .email)
                
                Spacer().frame(height: 49)
                
                CustomTextField(placeholder: "비밀번호", text: $password)
                    .focused($focusField, equals: .password)
            }
            
            Spacer().frame(height: 428)
            
            Button(action: {
                if nickname.isEmpty {
                    focusField = .nickname
                } else if email.isEmpty {
                    focusField = .email
                } else if password.isEmpty {
                    focusField = .password
                } else {
                    print("생성하기 버튼 클릭")
                    focusField = nil
                }
            }) {
                HStack {
                    Spacer()
                    
                    Text("생성하기")
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                .frame(height: 46)
                .background(Color.mainGreen)
                .cornerRadius(20)
            }
        }
        .padding(.horizontal, 19)
    }
}

#Preview {
    SignupView()
}

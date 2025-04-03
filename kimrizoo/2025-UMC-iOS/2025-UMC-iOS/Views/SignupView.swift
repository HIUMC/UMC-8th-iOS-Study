//
//  SignupView.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 3/25/25.
//

import SwiftUI

import SwiftUI

struct SignupView: View {
    @AppStorage("nickname") private var nickname = ""
    @AppStorage("email") private var email = ""
    @AppStorage("password") private var password = ""
    
    @FocusState private var focusField: Field?
    @Environment(\.dismiss) private var dismiss
    
    enum Field: Hashable {
        case nickname, email, password
    }
    
    var body: some View {
        VStack {
            CustomNavigationBar(title: "가입하기", onBack: {
                dismiss()
            })

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
                    print("회원가입 성공! 저장 완료.")
                    dismiss()
                }
            }) {
                HStack {
                    Spacer()
                    Text("생성하기")
                        .foregroundStyle(.white)
                    Spacer()
                }
                .frame(height: 46)
                .background(Color.green)
                .cornerRadius(20)
            }
        }
        .padding(.horizontal, 19)
    }
}


#Preview {
    SignupView()
}

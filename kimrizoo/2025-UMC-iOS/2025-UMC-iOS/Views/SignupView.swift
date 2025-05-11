//
//  SignupView.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 3/25/25.
//
import SwiftUI

struct SignupView: View {
    @State private var viewModel = SignupViewModel()
    @FocusState private var focusField: Field?
    @Environment(\.dismiss) private var dismiss
    
    enum Field: Hashable {
        case nickname, email, password
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(title: "가입하기", onBack: {
                dismiss()
            })
            
            Spacer().frame(height: 134)
            
            ScrollView {
                VStack(spacing: 49) {
                    CustomTextField(placeholder: "닉네임", text: $viewModel.nickname)
                        .focused($focusField, equals: .nickname)
                    
                    CustomTextField(placeholder: "이메일", text: $viewModel.email)
                        .focused($focusField, equals: .email)
                    
                    CustomTextField(placeholder: "비밀번호", text: $viewModel.password)
                        .focused($focusField, equals: .password)
                }
            }

            Button(action: {
                if viewModel.nickname.isEmpty {
                    focusField = .nickname
                } else if viewModel.email.isEmpty {
                    focusField = .email
                } else if viewModel.password.isEmpty {
                    focusField = .password
                } else {
                    viewModel.signup()
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
            .padding(.top, 24)
        }
        .padding(.horizontal, 19)
        .padding(.bottom, 20)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    SignupView()
}

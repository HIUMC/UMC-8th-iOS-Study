//
//  SignupView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 3/30/25.
//

import SwiftUI
import Observation

struct SignupView: View {
    @FocusState private var nicknameFocused: Bool
    @FocusState private var emailFocused: Bool
    @FocusState private var passwordFocused: Bool
    
    @StateObject private var signupViewModel: SignupViewModel = .init()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            top
            Spacer()
            createButton
        }
        .padding(EdgeInsets(top: 172, leading: 19, bottom: 72, trailing: 19))
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                }
                .foregroundStyle(Color("black00"))
            }
            
            ToolbarItem(placement: .principal) {
                Text("가입하기")
                    .font(.mainTextMedium16)
                    .foregroundStyle(Color("black00"))
            }
        })
    }
    
    private var top: some View {
        VStack(alignment: .leading, spacing: 49) {
            customTextField(placeholder: "닉네임", text: $signupViewModel.nickname, focus: $nicknameFocused)
            customTextField(placeholder: "이메일", text: $signupViewModel.email, focus: $emailFocused)
            customTextField(placeholder: "비밀번호", text: $signupViewModel.password, focus: $passwordFocused)
        }
    }
    
    private func customTextField(placeholder: String, text: Binding<String>, focus: FocusState<Bool>.Binding) -> some View {
        VStack(spacing: 2) {
            TextField(placeholder, text: text, prompt: Text(placeholder))
                .foregroundStyle(focus.wrappedValue ? Color("gray06") : Color("gray02"))
            .font(.mainTextRegular18)
            .foregroundStyle(Color("black01"))
            .focused(focus)
            
            Divider()
                .background(focus.wrappedValue ? Color("green01") : Color("gray02"))
        }
    }
    
    private var createButton: some View {
        Button(action: {
            signupViewModel.createUser(nickname: signupViewModel.nickname, email: signupViewModel.email, password: signupViewModel.password)
            dismiss()
        }, label: {
            Text("생성하기")
                .font(.mainTextMedium16)
                .foregroundStyle(Color("white01"))
                .frame(maxWidth: .infinity, maxHeight: 58)
                .background() {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("green01"))
                        .frame(height: 58)
                }
        })
    }
}

#Preview {
    SignupView()
}

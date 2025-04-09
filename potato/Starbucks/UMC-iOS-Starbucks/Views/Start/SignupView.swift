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
    
    @EnvironmentObject private var router: NavigationRouter
//    @Environment(\.dismiss) var dismiss
    
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
//                    dismiss()
                    router.pop()
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
        /*
         문제점: name만 변경하고 싶어도 화면에 들어오면 email, password = ""이 된다.
         회원가입 화면이라서 화면이 나타날 때마다 초기화해도 괜찮을 것 같아서 냅둠.
         */
        .onAppear {
            signupViewModel.nickname = ""
            signupViewModel.email = ""
            signupViewModel.password = ""
        }
    }
    
    private func customTextField(placeholder: String, text: Binding<String>, focus: FocusState<Bool>.Binding) -> some View {
        VStack(spacing: 2) {
            TextField(placeholder, text: text, prompt: Text(placeholder)
                .foregroundStyle(Color("gray02")))
            .font(.mainTextRegular18)
            .foregroundStyle(Color("black01"))
            .focused(focus)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            
            Divider()
                .background(focus.wrappedValue ? Color("green01") : Color("gray02"))
        }
    }
    
    private var createButton: some View {
        Button(action: {
            if signupViewModel.nickname.isEmpty || signupViewModel.email.isEmpty || signupViewModel.password.isEmpty {
                print("채우지 않은 필드가 있습니다")
            } else {
                signupViewModel.createUser(nickname: signupViewModel.nickname, email: signupViewModel.email, password: signupViewModel.password)
//                dismiss()
                router.pop()
            }
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

//
//  SignupView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 3/26/25.
//

import SwiftUI

struct SignupView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SignupViewModel()
    @FocusState private var isNameFocused: Bool
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    
    
    @AppStorage("savedEmail") var savedEmail: String = ""
    @AppStorage("savedPassword") var savedPassword: String = ""
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 상단 네비게이션 (뒤로가기 + 타이틀)
            ZStack {
                // 가운데 타이틀
                Text("가입하기")
                    .foregroundColor(.black01)
                    .font(.mainTextSemiBold16)

                // 왼쪽 뒤로가기 버튼
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black01)
                            .font(.mainTextSemiBold16)
                    }
                    Spacer()
                }
            }
            .padding(.top, 50)
            .padding(.horizontal, 26)
            .navigationBarBackButtonHidden(true)

            Spacer().frame(height: 40)

            Group {
                Text("닉네임")
                    .font(.mainTextRegular18)
                    .foregroundColor(.grey02)

                TextField("", text: $viewModel.name)
                    .font(.mainTextRegular9)
                    .foregroundColor(.black01)
                    .focused($isNameFocused)

                Divider().background(isNameFocused ? Color.green01 : Color.grey00)
            }

            Spacer().frame(height: 30)

            Group {
                Text("이메일")
                    .font(.mainTextRegular18)
                    .foregroundColor(.grey02)

                TextField("", text: $viewModel.email)
                    .font(.mainTextRegular9)
                    .foregroundColor(.black01)
                    .focused($isEmailFocused)

                Divider().background(isEmailFocused ? Color.green01 : Color.grey00)
            }

            Spacer().frame(height: 30)

            Group {
                Text("비밀번호")
                    .font(.mainTextRegular18)
                    .foregroundColor(.grey02)

                TextField("", text: $viewModel.password)
                    .font(.mainTextRegular9)
                    .foregroundColor(.black01)
                    .focused($isPasswordFocused)

                Divider().background(isPasswordFocused ? Color.green01 : Color.grey00)
            }

            Spacer().frame(height: 50)

            Button(action: {
                if !viewModel.name.isEmpty && !viewModel.email.isEmpty && !viewModel.password.isEmpty {
                    viewModel.saveUserInfo()
                    isLoggedIn = true
                    dismiss()
                }
            }) {
                Image(.generatebutton)
                    .resizable()
                    .scaledToFit()
            }

            Spacer()
        }
        .padding(.horizontal, 19)
        .background(Color.white.ignoresSafeArea())
    }

}


#Preview {
    SignupView()
}

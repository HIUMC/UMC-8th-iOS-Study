//
//  SignupView.swift
//  Starbucks
//
//  Created by 이가원 on 3/28/25.
//

import SwiftUI

struct SignupView: View {
    @AppStorage("Nickname") var savedNickname: String = ""
    @AppStorage("Email") var savedEmail: String = ""
    @AppStorage("Password") var savedPassword: String = ""
    @State private var viewModel = SignupViewModel()
    @Environment(\.dismiss) var dismiss
    let keychain = KeychainAccountService.shared
    
    var body: some View {
        VStack {
            Spacer().frame(height:210)
            topView
            Spacer().frame(height: 428)
            Button(action: {
                if !viewModel.nickname.isEmpty &&
                        !viewModel.email.isEmpty &&
                    !viewModel.password.isEmpty {
                    let(nickname, email, password) = viewModel.getSignupData()
                    keychain.save(value: nickname, for: .nickname)
                    keychain.save(value: email, for: .email)
                    keychain.save(value: password, for: .password)

                    dismiss()
                    
                }
            }) {
                Text("생성하기")
                    .font(.custom("Pretendard-Medium", size: 18))
                    .foregroundColor(.white)
                    .frame(width: 402, height: 58)
                    .background(Color("green1"))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
        
        }
        .ignoresSafeArea()
        .navigationTitle("가입하기")
        .navigationBarBackButtonHidden(false)
    }
    private var topView: some View {
        VStack(alignment: .leading, spacing: 49) {
            VStack(alignment: .leading){
                TextField("닉네임", text: $viewModel.nickname)
                    .font(.custom("Pretendard-Regular", size: 18))
                    .foregroundColor(.black)
                  

                Divider()
                    .frame(width: 402)
            }
            VStack(alignment: .leading){
                TextField("이메일", text: $viewModel.email)
                    .font(.custom("Pretendard-Regular", size: 18))
                    .foregroundColor(.black)
                   

                Divider()
                    .frame(width: 402)
            }
            VStack(alignment: .leading){
                TextField("비밀번호", text: $viewModel.password)
                    .font(.custom("Pretendard-Regular", size: 18))
                    .foregroundColor(.black)
            

                Divider()
                    .frame(width: 402)
            }
            
        }
        .padding(.leading)
    }
}

#Preview {
    SignupView()
}

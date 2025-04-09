//
//  SignupView.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/26/25.
//

import SwiftUI

struct SignupView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var signupViewModel: SignupViewModel
    @AppStorage("nickname") private var storedNickname = ""
    @AppStorage("email") private var storedEmail = ""
    @AppStorage("pwd") private var storedPwd = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 172)
            
            // 텍스트 필드 영역
            SignupTextView(signupViewModel: signupViewModel)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            
            Spacer()
            
            // 생성하기 버튼 영역
            mainBottom
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            
            Spacer().frame(height: 72)
        }
        .navigationTitle("가입하기")
        .font(.mainTextMedium16)
    }
    
    private var mainBottom: some View {
        Button(action: {
            print("버튼 눌림")
            if signupViewModel.nickname.count > 0 &&
                signupViewModel.email.count > 0 &&
                signupViewModel.pwd.count > 0 {
                
                storedNickname = signupViewModel.nickname
                storedEmail = signupViewModel.email
                storedPwd = signupViewModel.pwd
                
                dismiss()
            }
        }) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.green01)
                .frame(maxWidth: .infinity)  // 부모의 너비에 맞춰 확장
                .frame(height: 58)
                .overlay(
                    Text("생성하기")
                        .font(.makeMedium18)
                        .foregroundStyle(Color.white)
                )
                .padding(.horizontal)
        }
    }
}

#Preview {
    SignupView(signupViewModel: SignupViewModel())
}

struct SignupTextView: View {
    @Bindable var signupViewModel: SignupViewModel
    var body: some View {
        VStack(alignment: .leading) {
            TextField("닉네임", text: $signupViewModel.nickname)
                .font(.mainTextRegular13)
                .foregroundStyle(Color.black01)
            
            Rectangle()
                .frame(height: 0.7)
                .padding(.bottom, 49)
                .foregroundStyle(Color.gray00)
            
            TextField("이메일", text: $signupViewModel.email)
                .font(.mainTextRegular13)
                .foregroundStyle(Color.black01)
            
            Rectangle()
                .frame(height: 0.7)
                .padding(.bottom, 49)
                .foregroundStyle(Color.gray00)
            
            TextField("비밀번호", text: $signupViewModel.pwd)
                .font(.mainTextRegular13)
                .foregroundStyle(Color.black01)
            
            Rectangle()
                .frame(height: 0.7)
                .foregroundStyle(Color.gray00)
        }
    }
}



//
//  SignupView.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/26/25.
//

import SwiftUI

struct SignupView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var signupViewModel = SignupViewModel()

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
    
        .font(.mainTextMedium16)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(.back2)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }

            ToolbarItem(placement: .principal) {
                Text("가입하기")
                    .font(.mainTextMedium16) 
            }
        
        }
    }

    private var mainBottom: some View {
        Button(action: {
            print("버튼 눌림")
            if signupViewModel.nickname.count > 0 &&
                signupViewModel.email.count > 0 &&
                signupViewModel.pwd.count > 0 {

                signupViewModel.storedNickname = signupViewModel.nickname
                signupViewModel.storedEmail = signupViewModel.email
                signupViewModel.storedPwd = signupViewModel.pwd

//                dismiss()
            }
        }) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.green01)
                .frame(maxWidth: .infinity)
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


struct SignupTextView: View {
    @ObservedObject var signupViewModel: SignupViewModel
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

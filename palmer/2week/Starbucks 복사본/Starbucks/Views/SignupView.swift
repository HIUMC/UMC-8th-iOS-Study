//
//  SignupView.swift
//  Starbucks
//
//  Created by 박정환 on 3/29/25.
//

import SwiftUI
import Observation

struct SignupView: View {
    var viewModel : SignupViewModel = .init()
    
    var body: some View {
        VStack(spacing: 30) {
            Text("회원 가입")
                .font(.largeTitle)
                .padding(.bottom, 40)
            
            // 닉네임 입력 필드
            TextField("닉네임", text: $viewModel.nickname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 30)

            // 이메일 입력 필드
            TextField("이메일", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 30)

            // 비밀번호 입력 필드
            TextField("비밀번호", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 30)

            // 생성하기 버튼
            Button(action: {
                viewModel.saveToAppStorage()
            }, label: {
                Text("생성하기")
                    .font(.PretendardMedium18)
                    .foregroundStyle(.white)
                    .frame(maxWidth: 402, maxHeight: 58)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.green01)
                    )
            })
        }
        .padding()
    }
}

#Preview {
    SignupView()
}

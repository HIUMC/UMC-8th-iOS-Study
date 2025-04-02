//
//  SignupView.swift
//  Starbucks
//
//  Created by 박정환 on 3/29/25.
//

import SwiftUI
import Observation

struct SignupView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var signupViewModel: SignupViewModel
    @State private var router = NavigationRouter()
    
    @AppStorage("nickname") private var storedNickname = ""
    @AppStorage("email") private var storedEmail = ""
    @AppStorage("password") private var storedPassword = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomNav(title: "가입하기", onBack: {
                router.pop()
            })
                
            VStack(spacing:9){
                    TextField("닉네임", text: $signupViewModel.nickname)
                        .font(.mainTextRegular13)
                        .foregroundStyle(Color("black01"))
                    
                    Divider()
                    Spacer()
                    TextField("이메일", text: $signupViewModel.email)
                        .font(.mainTextRegular13)
                        .foregroundStyle(Color("black01"))
                    
                    Divider()
                    Spacer()
                    TextField("비밀번호", text: $signupViewModel.password)
                        .font(.mainTextRegular13)
                        .foregroundStyle(Color("black01"))
                    
                    Divider()
                }.frame(height:188)
                    .padding(.horizontal, 19)
                    .padding(.top, 210)
                
                Spacer()
                
                //생성 버튼
                Button(action: {
                    print("버튼 눌림")
                    router.pop()
                    if signupViewModel.nickname.count > 0 &&
                        signupViewModel.email.count > 0 &&
                        signupViewModel.password.count > 0 {
                        
                        storedNickname = signupViewModel.nickname
                        storedEmail = signupViewModel.email
                        storedPassword = signupViewModel.password
                        
                    }
                }) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("green01"))
                        .frame(height: 58)
                        .overlay(
                            Text("생성하기")
                                .font(.makeMedium18)
                                .foregroundStyle(Color.white)
                        )
                        .padding(.horizontal)
                        .padding(.bottom, 72)
                }
                .navigationTitle("가입하기")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
            }
    }
}

#Preview {
    SignupView(signupViewModel: SignupViewModel())
}

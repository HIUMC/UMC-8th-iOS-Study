//
//  SignupView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/30/25.
//

import SwiftUI

struct SignupView: View {
    
    @State var signviewModel = SignupViewModel()
    
    var body: some View {
        
        Spacer().frame(height: 210)
        VStack {
            VStack(alignment: .leading) {
                
                TextField(
                    "닉네임", // 접근성용
                    text: $signviewModel.signupModel.nickname,
                    prompt: Text("닉네임")
                        .font(.PretendardRegular18)
                        .foregroundStyle(Color.signupGray)
                        .kerning(-0.65)
                ) //❗️ 주의: $viewModel.nickname ← 이건 안 돼요. signupModel 안에 들어 있으니까 경로를 따라가야 해요.
                
                
                Divider()
                    .padding(.bottom, 47)
                //Spacer().frame(height: 47)
                
                
                // -------------------------------
                
                TextField(
                    "이메일 계정", // 접근성용
                    text: $signviewModel.signupModel.emailAccount,
                    prompt: Text("이메일")
                        .font(.PretendardRegular18)
                        .foregroundStyle(Color.signupGray)
                        .kerning(-0.65)
                )
                
                Divider()
                    .padding(.bottom, 47)
                //Spacer().frame(height: 47)
                
                TextField(
                    "비밀번호", // 접근성용
                    text: $signviewModel.signupModel.password,
                    prompt: Text("비밀번호")
                        .font(.PretendardRegular18)
                        .foregroundStyle(Color.signupGray)
                        .kerning(-0.65)
                ) //❗️ 주의: $viewModel.nickname ← 이건 안 돼요. signupModel 안에 들어 있으니까 경로를 따라가야 해요.
                
                
                
                Divider()
            
            }
            
            Spacer()
            
            
            Button(action: {signviewModel.saveUserData()}) {
                Text("생성하기")
                    .font(.PretendardMedium18)
                    .frame(maxWidth: .infinity, minHeight: 46) //크기 정하고 배경 정하고 코너 깎기
                    .background(Color.loginButtonGreen)
                    .foregroundStyle(.white)
                //.cornerRadius(20) => 🚨 clipshape로 ! deprecated
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                // 🐱 clipShape 쓰면 다른 도형으로 바꾸기도 쉽고 테두리도 넣고 좋아용
                
            }// 버튼 뷰
            Spacer().frame(height: 72)
            
            
            
            
            
        } //VStack
        .padding(.horizontal, 19) // 양옆
        
        
        
    }
    
    
}

#Preview {
    SignupView()
}

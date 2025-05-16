//
//  SignupView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/30/25.
//

// ✴️ 구조체에 닉네임 이메일 비밀번호 시리즈 담아서 init ,, 더 쉽게 구현 가능한가?
// ✴️ Rectangle 이 부분도 같이 묶을 수 있나?
// ✴️ 네비게이션 하위 뷰? 어떻게 할 수 있지?

import SwiftUI

struct SignupView: View {
    @Environment(\.dismiss) var dismiss
    @State var signviewModel = SignupViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                VStack(alignment: .leading) { //v3
                  
                    makeNickname
                    Rectangle()
                        .frame(height: 0.7)
                        .foregroundStyle(Color.signupGray)
                        .padding(.bottom, 47)

                    makeEmail
                    Rectangle()
                        .frame(height: 0.7)
                        .foregroundStyle(Color.signupGray)
                        .padding(.bottom, 47)
                    
                    makePwd
                    Rectangle()
                        .frame(height: 0.7)
                        .foregroundStyle(Color.signupGray)
                        .padding(.bottom, 47)
                    
                    
                } // v3
                Spacer()
                
                
                makeButton
                
                Spacer().frame(height: 72)
                
            } //VStack
            
            .padding(.horizontal, 19) // 양옆
            .navigationBarBackButtonHidden(true) // 기본 뒤로가기 버튼 숨기기
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.black)
                    }
                } // <
                
                ToolbarItem(placement: .principal) { // .center가 없다!
                    Text("가입하기")
                        .font(.PretendardMedium16)
                        .foregroundStyle(Color.black00)
                }
            }
            
        }
        
    }
    
    
    private var makeNickname: some View {
        TextField(
            "닉네임", // 접근성용
            text: $signviewModel.signupModel.nickname,
            prompt: Text("닉네임")
                .font(.PretendardRegular18)
                .foregroundStyle(Color.signupGray)
                .kerning(-0.65)
        ) //❗️ 주의: $viewModel.nickname ← 이건 안 됨
        //signupModel 안에 들어 있으니까 경로를 따라가야 함
        
    }
    
    private var makeEmail: some View {
        TextField(
            "이메일 계정", // 접근성용
            text: $signviewModel.signupModel.emailAccount,
            prompt: Text("이메일")
                .font(.PretendardRegular18)
                .foregroundStyle(Color.signupGray)
                .kerning(-0.65)
        )
    }
    
    private var makePwd: some View {
        TextField(
            "비밀번호", // 접근성용
            text: $signviewModel.signupModel.password,
            prompt: Text("비밀번호")
                .font(.PretendardRegular18)
                .foregroundStyle(Color.signupGray)
                .kerning(-0.65)
        )
    }
    
    
    private var makeButton: some View {
        Button(action: {
            if signviewModel.signupModel.nickname.count > 0 &&
                signviewModel.signupModel.emailAccount.count > 0 &&
                signviewModel.signupModel.password.count > 0 {
                
                signviewModel.saveUserData()
                
                let token = TokenInfo(
                    accessToken: signviewModel.signupModel.emailAccount,
                    refreshToken: signviewModel.signupModel.password,
                    nickname: signviewModel.signupModel.nickname
                )
                KeychainService.shared.saveToken(token)

                UserDefaults.standard.set(signviewModel.signupModel.nickname, forKey: "nickname")
                print("✅ 저장된 닉네임:", signviewModel.signupModel.nickname)
                dismiss()
            }
        }) {
            Text("생성하기")
                .font(.PretendardMedium18)
                .frame(maxWidth: .infinity, minHeight: 46) //크기 정하고 배경 정하고 코너 깎기
                .background(Color.loginButtonGreen)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
        }// 버튼 뷰
    }
    
}
#Preview {
    NavigationStack {
        SignupView()
    }
}

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
    @ObservedObject var signupViewModel: SignupViewModel
    @State private var router = NavigationRouter()
    
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomNav(title: "가입하기")
            
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
                TextField("비밀번호", text: Binding(
                    get: { signupViewModel.password },
                    set: { signupViewModel.password = $0 }
                ))
                    .font(.mainTextRegular13)
                    .foregroundStyle(Color("black01"))
                
                Divider()
            }
            .frame(height:188)
            .padding(.horizontal, 19)
            .padding(.top, 210)
            
            Spacer()
            
            Button(action: {
                print("버튼 눌림")
                if signupViewModel.nickname.count > 0 &&
                    signupViewModel.email.count > 0 &&
                    signupViewModel.password.count > 0 {
                    
                    // Keychain에 데이터 저장
                    let token = TokenInfo(
                        accessToken: signupViewModel.email,
                        refreshToken: signupViewModel.password
                    )
                    KeychainService.shared.saveToken(token)
                    
                    dismiss()
                } else {
                    print("모든 값을 한 글자 이상 입력해주세요!")
                }
            }, label: {
                Text("생성하기")
                    .font(.makeMedium18)
                    .foregroundStyle(.white)
                    .frame(maxWidth: 402, maxHeight: 58)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.green01)
                    )
            })
            .padding(.horizontal)
            .padding(.bottom, 72)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SignupView(signupViewModel: SignupViewModel())
}

//
//  LoginView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 3/30/25.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKUser

struct LoginView: View {
    @State private var viewModel: LoginViewModel = .init()
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        VStack {
            title
            Spacer()
            login
            Spacer()
            socialLogin
        }
        .navigationBarBackButtonHidden(true)
        .padding(EdgeInsets(top: 104, leading: 19, bottom: 62.95, trailing: 19))
    }
    
    private var title: some View {
        HStack {
            VStack(alignment: .leading, spacing: 28) {
                Image(.starbucksLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 97, height: 95)
                
                VStack(alignment: .leading, spacing: 19) {
                    Text("안녕하세요.\n스타벅스입니다.")
                        .font(.mainTextExtraBold24)
                        .kerning(1.2)
                        .foregroundStyle(Color("black00"))
                    
                    Text("회원 서비스 이용을 위해 로그인 해주세요")
                        .font(.mainTextMedium16)
                        .foregroundStyle(Color("gray01"))
                }
            }
            Spacer()
        }
    }
    
    @State private var id: String = ""
    @FocusState private var idFieldIsFocused: Bool
    @State private var pwd: String = ""
    @FocusState private var pwFieldIsFocused: Bool
    
//    @AppStorage("email") var email: String = ""
//    @AppStorage("password") var password: String = ""
    
    let keychain = KeychainService.shared
    
    private var login: some View {
        VStack(spacing: 47) {
            customTextField(placeholder: "아이디", text: $id, focus: $idFieldIsFocused)
            customTextField(placeholder: "비밀번호", text: $pwd, focus: $pwFieldIsFocused)
            
            Button(action: {
                if let user = keychain.loadUserInfo(email: id) {
                    if pwd == user.password {
                        print("로그인 성공")
                        router.push(.tab)
                    } else {
                        print("로그인 실패")
                    }
                } else {
                    print("저장된 회원 없음")
                }
            }, label: {
                Text("로그인하기")
                    .font(.mainTextMedium16)
                    .foregroundStyle(Color("white01"))
                    .frame(maxWidth: .infinity, maxHeight: 46)
                    .background() {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("green01"))
                            .frame(height: 46)
                    }
            })
        }
        .onAppear {
            viewModel.id = ""
            viewModel.pwd = ""
        }
    }
    
    private func customTextField(placeholder: String, text: Binding<String>, focus: FocusState<Bool>.Binding) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            TextField(placeholder, text: text, prompt: Text(placeholder)
                .foregroundStyle(Color("gray02")))
            .font(.mainTextRegular13)
            .foregroundStyle(Color("black01"))
            .focused(focus)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            
            Divider()
                .background(focus.wrappedValue ? Color("green01") : Color("gray02"))
        }
    }
    
    private var socialLogin: some View {
        VStack(spacing: 19) {
            Button(action: {
                router.push(.signup)
            }, label: {
                Text("이메일로 회원가입하기")
                    .font(.mainTextRegular12)
                    .underline()
                    .foregroundStyle(Color("gray04"))
            })
            
            Button(action: {
                if (UserApi.isKakaoTalkLoginAvailable()) {
                    UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            print("loginWithKakaoTalk() success.")
                            
                            // 성공 시 동작 구현
                            _ = oauthToken
                            
                            let keychain = KeychainService.shared
                            let tokenInfo = TokenInfo(accessToken: oauthToken!.accessToken, refreshToken: oauthToken!.refreshToken)
                            keychain.saveToken(tokenInfo)
                            router.push(.tab)
                        }
                    }
                }
            }, label: {
                Image(.kakaoLogin)
            })
            
            Image(.appleLogin)
        }
    }
}

#Preview() {
    LoginView()
}

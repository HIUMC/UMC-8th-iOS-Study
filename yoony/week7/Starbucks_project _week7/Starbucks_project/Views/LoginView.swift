//
//  LoginView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 3/20/25.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @FocusState private var isIDFocused: Bool
    @FocusState private var isPWFocused: Bool
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("savedEmail") var savedEmail: String = "Yys"
    @AppStorage("savedPassword") var savedPassword: String = "0630"
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                
                // MARK: - 로고 & 인사말
                Image(.starbuckslogo)
                    .resizable()
                    .frame(width: 97, height: 95)
                    .padding(.top, 32)
                
                Spacer().frame(height: 28)
                
                Text("안녕하세요. \n스타벅스입니다.")
                    .font(.mainTextExtraBold24)
                    .foregroundColor(.black01)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer().frame(height: 19)
                
                Text("회원 서비스 이용을 위해 로그인 해주세요")
                    .font(.mainTextMedium16)
                    .foregroundColor(.grey01)
                
                Spacer().frame(height: 60)
                
                // MARK: - 아이디 입력
                Text("아이디")
                    .font(.mainTextRegular13)
                    .foregroundColor(.black01)
                
                TextField("", text: $viewModel.ID)
                    .font(.mainTextRegular9)
                    .foregroundColor(.black01)
                    .focused($isIDFocused)
                
                Divider()
                    .background(isIDFocused ? Color.green01 : Color.grey00)
                
                Spacer().frame(height: 47)
                
                // MARK: - 비밀번호 입력
                Text("비밀번호")
                    .font(.mainTextRegular13)
                    .foregroundColor(.black01)
                
                TextField("", text: $viewModel.PW)
                    .font(.mainTextRegular9)
                    .foregroundColor(.black01)
                    .focused($isPWFocused)
                
                Divider()
                    .background(isPWFocused ? Color.green01 : Color.grey00)
                
                Spacer().frame(height: 47)
                
                // MARK: - 로그인 버튼 (가운데 정렬)
                Button(action: {
                    if viewModel.ID == savedEmail && viewModel.PW == savedPassword {
                        isLoggedIn = true
                    }
                }) {
                    Image(.loginimage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 370, height: 46)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer().frame(height: 60)
                
                // MARK: - 이메일 회원가입
                NavigationLink(destination: SignupView()) {
                    Text("이메일로 회원가입하기")
                        .font(.mainTextRegular12)
                        .foregroundColor(.grey04)
                        .underline()
                        .baselineOffset(2)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer().frame(height: 19)
                
                // MARK: - 카카오 로그인
                Button {
                    kakaoLogin()
                } label: {
                    Image(.loginframe1)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 306, height: 45)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer().frame(height: 19)
                
                Button {
                    // Apple 로그인 or 기타
                } label: {
                    Image(.loginframe2)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 306, height: 45)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
            }
            .padding(.horizontal, 30) // ✅ 좌우 동일 여백
        }
    }
    
    // MARK: - 카카오 로그인 함수
    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print("카카오톡 로그인 실패: \(error)")
                } else if let token = oauthToken {
                    print("카카오톡 로그인 성공")
                    let tokenInfo = TokenInfo(
                        accessToken: token.accessToken,
                        refreshToken: token.refreshToken
                    )
                    KeychainService.shared.saveToken(tokenInfo)
                    
                    UserApi.shared.me { user, _ in
                        if let nickname = user?.kakaoAccount?.profile?.nickname {
                            KeychainService.shared.saveNickname(nickname)
                        }
                    }
                    isLoggedIn = true
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print("카카오계정 로그인 실패: \(error)")
                } else if let token = oauthToken {
                    print("카카오계정 로그인 성공")
                    let tokenInfo = TokenInfo(
                        accessToken: token.accessToken,
                        refreshToken: token.refreshToken
                    )
                    KeychainService.shared.saveToken(tokenInfo)
                    
                    UserApi.shared.me { user, _ in
                        if let nickname = user?.kakaoAccount?.profile?.nickname {
                            KeychainService.shared.saveNickname(nickname)
                        }
                    }
                    isLoggedIn = true
                }
            }
        }
    }
}

#Preview {
    LoginView()
}

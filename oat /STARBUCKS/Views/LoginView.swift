//
//  LoginView.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/23/25.
//

import SwiftUI
import Foundation

struct LoginView: View {
    // ─ 기존 로그인 필드(AppStorage) ─
    @AppStorage("email") private var storedEmail: String = ""
    @AppStorage("pwd")   private var storedPwd:   String = ""
    
    // ─ 로컬 화면 전환 바인딩 ─
    @State private var isLoggedIn: Bool = false
    
    // ─ 뷰모델 (이메일/비번 + 카카오 OAuth 담당) ─
    @StateObject private var loginVM = LoginViewModel()
    
    // ─ SwiftUI URL 열기 도우미 ─
    @Environment(\.openURL) private var openURL

    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 104)
                mainTitleGroup
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Spacer()
                mainMiddleGroup
                Spacer()
                mainBottomGroup
                    .frame(maxWidth: .infinity)
                Spacer()

                // ▶︎ 여기만 바꿔주세요!
                NavigationLink(
                    destination: iconView(),
                    isActive: $isLoggedIn     // ← 로컬 상태
                ) {
                    EmptyView()
                }
            }
            // 카카오 Redirect 콜백 잡기
            .onOpenURL { url in
                loginVM.handleKakaoRedirect(url)
            }
            // 뷰모델에서 성공 신호 오면 로컬 상태에 복사
            .onReceive(loginVM.$isLoggedIn) { success in
                if success {
                    isLoggedIn = true
                }
            }
        }
    }

    private var mainTitleGroup: some View {
        VStack(alignment: .leading) {
            Image(.starbuckLogo)
                .resizable()
                .frame(width: 97, height: 95)
                .padding(.bottom, 28)
            Text("안녕하세요.").font(.mainTextExtraBold24)
            Text("스타벅스입니다.").font(.mainTextExtraBold24)
            Text("회원 서비스 이용을 위해 로그인 해주세요.")
                .font(.mainTextMedium16)
                .foregroundStyle(Color.gray02)
                .padding(.top)
        }
    }

    private var mainMiddleGroup: some View {
        VStack(alignment: .leading) {
            LoginTextView(loginViewModel: loginVM)
            Button {
                // 이메일/비번 로그인 시도 → 뷰모델 내부에서 isLoggedIn = true 로 세팅
                _ = loginVM.loginWithEmail()
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.green01)
                    .frame(height: 46)
                    .overlay(
                        Text("로그인하기")
                            .font(.mainTextMedium16)
                            .foregroundStyle(Color.white)
                    )
            }
        }
        .padding(.horizontal)
    }

    private var mainBottomGroup: some View {
        VStack {
            NavigationLink(destination: SignupView()) {
                Text("이메일로 회원가입하기")
                    .underline()
                    .font(.mainTextRegular12)
                    .foregroundStyle(Color.gray00)
                    .padding(.bottom, 19)
            }

            // 카카오 로그인 버튼
            Button {
                if let url = loginVM.kakaoAuthURL {
                    openURL(url)
                }
            } label: {
                Image(.kakao)
                    .resizable()
                    .frame(width: 306, height: 45)
                    .padding(.bottom, 19)
            }

            Image(.apple)
                .resizable()
                .frame(width: 306, height: 45)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct LoginTextView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    @FocusState private var isID: Bool
    @FocusState private var isPwd: Bool

    var body: some View {
        VStack(alignment: .leading) {
            // 아이디
            ZStack(alignment: .leading) {
                if loginViewModel.id.isEmpty {
                    Text("아이디")
                        .foregroundColor(.black)
                        .font(.mainTextRegular13)
                }
                TextField("", text: $loginViewModel.id)
                    .focused($isID)
                    .font(.mainTextRegular13)
                    .foregroundStyle(Color.black01)
            }
            Rectangle()
                .frame(height: 0.7)
                .foregroundStyle(isID ? Color.green01 : Color.gray00)
                .padding(.bottom, 47)

            // 비밀번호
            ZStack(alignment: .leading) {
                if loginViewModel.pwd.isEmpty {
                    Text("비밀번호")
                        .foregroundColor(.black)
                        .font(.mainTextRegular13)
                }
                SecureField("", text: $loginViewModel.pwd)
                    .focused($isPwd)
                    .font(.mainTextRegular13)
                    .foregroundStyle(Color.black01)
            }
            Rectangle()
                .frame(height: 0.7)
                .foregroundStyle(isPwd ? Color.green01 : Color.gray00)
                .padding(.bottom, 47)
        }
    }
}

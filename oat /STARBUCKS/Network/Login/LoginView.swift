//
//  LoginView.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/23/25.
//
import SwiftUI

struct LoginView: View {
    @StateObject private var loginVM = LoginViewModel()

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

                // 로그인 성공 시 화면 전환
                NavigationLink(
                    destination: iconView(),
                    isActive: $loginVM.isLoggedIn
                ) {
                    EmptyView()
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
            // 이메일/비번 입력 필드
            LoginTextView(id: $loginVM.id, pwd: $loginVM.pwd)
            
            // 이메일 로그인 버튼
            Button {
                loginVM.loginWithEmail()
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
                Task {
                        do {
                            // 복사한 인가코드 직접 입력
                            let token = try await KakaoAPIService.shared.requestToken(code: "_gpUhZpD0ml6v74BmT2kcbEh9KKKmd5EkRc1UN8U4M-AzIppUdVtOQAAAAQKFwAnAAABlxE0vInSDh85zpcCzQ")
                            
                            // 로그인 상태 변경
                            UserManager.shared.isLoggedIn = true
                            print("✅ 카카오 로그인 성공")
                        } catch {
                            print("❌ 카카오 로그인 실패:", error)
                        }
                    }
            } label: {
                Image(.kakao)
                    .resizable()
                    .frame(width: 306, height: 45)
                    .padding(.bottom, 19)
            }

            // 애플 로그인 버튼 
            Image(.apple)
                .resizable()
                .frame(width: 306, height: 45)
        }
        .navigationBarBackButtonHidden(true)
    }
}


struct LoginTextView: View {
    @Binding var id: String
    @Binding var pwd: String
    @FocusState private var isID: Bool
    @FocusState private var isPwd: Bool

    var body: some View {
        VStack(alignment: .leading) {
            // 아이디 입력
            ZStack(alignment: .leading) {
                if id.isEmpty {
                    Text("아이디")
                        .foregroundColor(.black)
                        .font(.mainTextRegular13)
                }
                TextField("", text: $id)
                    .focused($isID)
                    .font(.mainTextRegular13)
                    .foregroundStyle(Color.black01)
            }
            Rectangle()
                .frame(height: 0.7)
                .foregroundStyle(isID ? Color.green01 : Color.gray00)
                .padding(.bottom, 47)

            // 비밀번호 입력
            ZStack(alignment: .leading) {
                if pwd.isEmpty {
                    Text("비밀번호")
                        .foregroundColor(.black)
                        .font(.mainTextRegular13)
                }
                SecureField("", text: $pwd)
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


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

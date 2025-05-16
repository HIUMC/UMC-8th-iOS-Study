import SwiftUI

//MARK: -그냥.. 카카오에서 제공하는 SDK 사용

import KakaoSDKAuth
import KakaoSDKUser

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel() // 로그인 상태 및 입력값 관리하는 뷰모델
    @FocusState var focusField: Field? // 텍스트필드 포커스 관리
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false // 로그인 상태를 UserDefaults로 관리

    // MARK: - Body
    var body: some View {
        NavigationStack{
            VStack {
                Spacer().frame(height: 104)
                topView
                Spacer()
                middleView
                Spacer()
                bottomView
                Spacer()
            }
            
            
            .ignoresSafeArea()
        }
    }
    // MARK: - Top View (로고 및 인삿말 영역)
    private var topView: some View {
        VStack(alignment: .leading) {
            Image(.minilogo)
                .resizable()
                .frame(width: 96, height: 96)
                .padding(.bottom, 28)

            Text("안녕하세요.\n스타벅스입니다.")
                .font(.custom("Pretendard-ExtraBold", size: 24))
                .multilineTextAlignment(.leading)
                .lineSpacing(5)
                .padding(.bottom, 12)

            Text("회원 서비스 이용을 위해 로그인 해주세요")
                .font(.custom("Pretendard-Medium", size: 16))
                .foregroundColor(Color.gray01)
        }
        .frame(maxWidth: 402, alignment: .leading)
        .padding(.leading, 19)
    }

    // MARK: - Middle View (ID, PW 입력 및 로그인 버튼)
    private var middleView: some View {
        VStack(spacing: 47) {
            VStack(alignment: .leading, spacing: 8) {
                
                TextField("아이디", text: $viewModel.id)
                    .font(.custom("Pretendard-Regular", size: 13))
                    .foregroundColor(Color.black)
                    .focused($focusField, equals: .id)
                Divider()
                    .frame(width: 350)
                    .background(focusField == .id ? Color("green01"): Color.gray.opacity(0.3))
            }
            .padding(.leading, 19)

            VStack(alignment: .leading, spacing: 8) {
                TextField("비밀번호", text: $viewModel.password)
                    .font(.custom("Pretendard-Regular", size: 13))
                    .focused($focusField, equals: .password)
                Divider()
                    .frame(width: 350)
                    .background(focusField == .password ? Color("green01") : Color.gray.opacity(0.3))
            }
            .padding(.leading, 19)
            Button(action: {
                let storedEmail = KeychainAccountService.shared.load(for: .email)
                let storedPassword = KeychainAccountService.shared.load(for: .password)
                if viewModel.id == storedEmail && viewModel.password == storedPassword {
                    isLoggedIn = true
                } else {
                    print("로그인 실패: 저장된 정보와 일치하지 않음")
                }
            }) {
                Text("로그인하기")
                    .font(.custom("Pretendard-Medium", size: 16))
                    .foregroundColor(.white)
                    .frame(width: 382, height: 46)
                    .background(Color("green01"))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }

        }
    }

    // MARK: - Bottom View (회원가입, 카카오/애플 로그인 버튼)
    private var bottomView: some View {
        VStack(spacing: 19) {
            NavigationLink(destination:  SignupView(signupViewModel: SignupViewModel())) {
                Text("이메일로 회원가입하기")
                    .font(.custom("Pretendard-Regular", size: 12))
                    .foregroundColor(.gray03)
                    .underline()
            }

            VStack(spacing: 19) {
                // 로그인 성공 시 accessToken을 키체인에 저장하고 로그인 상태 true 설정
                Button(action: {
                    if UserApi.isKakaoTalkLoginAvailable() {
                        UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                            if let error = error {
                                print("카카오톡 로그인 실패: \(error.localizedDescription)")
                            } else {
                                if let accessToken = oauthToken?.accessToken {
                                    KeychainAccountService.shared.save(value: accessToken, for: .token) // accessToken을 키체인에 저장
                                    // 사용자 정보 요청 (email 저장)
                                    UserApi.shared.me { user, error in
                                        if let email = user?.kakaoAccount?.email {
                                            KeychainAccountService.shared.save(value: email, for: .email)
                                        }
                                    }
                                    isLoggedIn = true // 로그인 상태 저장 (다음 화면으로 전환 목적)
                                }
                            }
                        }
                    } else {
                        UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                            if let error = error {
                                print("카카오 계정 로그인 실패: \(error.localizedDescription)")
                            } else {
                                if let accessToken = oauthToken?.accessToken {
                                    KeychainAccountService.shared.save(value: accessToken, for: .token) // accessToken을 키체인에 저장
                                    // 사용자 정보 요청 (email 저장)
                                    UserApi.shared.me { user, error in
                                        if let email = user?.kakaoAccount?.email {
                                            KeychainAccountService.shared.save(value: email, for: .email)
                                        }
                                    }
                                    isLoggedIn = true // 로그인 상태 저장 (다음 화면으로 전환 목적)
                                }
                            }
                        }
                    }
                }) {
                    Image(.kakao)
                        .resizable()
                        .frame(width: 300, height: 45)
                }
                Image(.apple)
            }
        }
    }
    
}
// MARK: - FocusField 정의
enum Field {
    case id
    case password
}

// MARK: - Preview
#Preview {
    LoginView()
}

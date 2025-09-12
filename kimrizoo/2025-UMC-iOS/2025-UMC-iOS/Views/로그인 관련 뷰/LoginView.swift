import SwiftUI
import KakaoSDKUser
import KakaoSDKAuth

struct LoginView: View {
    @State private var id = ""
    @State private var password = ""
    @FocusState private var isFocused: Bool

    @EnvironmentObject var router: NavigationRouter

    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(maxHeight: 104)

            // 상단 인사말 및 로고
            VStack(alignment: .leading) {
                Image("Starbucks")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 97, height: 95)

                Spacer().frame(height: 28)

                Text("안녕하세요.\n스타벅스입니다.")
                    .font(.PretendardExtraBold24)
                    .foregroundStyle(.black)
                    .kerning(1.2)

                Spacer().frame(height: 19)

                Text("회원 서비스 이용을 위해 로그인 해주세요")
                    .font(.PretendardMedium16)
                    .foregroundStyle(.customGray1)
                    .kerning(-0.8)
            }

            Spacer()

            // 아이디/비밀번호 입력 필드
            VStack(alignment: .leading, spacing: 47) {
                CustomTextField(placeholder: "아이디", text: $id)
                CustomTextField(placeholder: "비밀번호", text: $password)
            }

            Spacer()

            // 로그인 버튼 및 소셜 로그인
            HStack {
                Spacer()
                VStack(spacing: 16) {
                    NavigationLink(value: Route.signup) {
                        Text("이메일로 회원가입하기")
                            .font(.PretendardRegular12)
                            .underline()
                            .foregroundStyle(.customGray2)
                    }

                    Button {
                        kakaoLogin()
                    } label: {
                        Image("_카카오 로그인")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 306, height: 45)
                    }

                    Image("appleLogin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 306, height: 45)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 19)
        .padding(.bottom, 62.4)
    }

    // MARK: - 카카오 로그인 함수 (안전하게 토큰 체크 및 에러 방지)
    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            // ✅ 카카오톡 로그인
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print("❌ 카카오톡 로그인 실패: \(error)")
                } else {
                    print("✅ 카카오톡 로그인 성공")
                    fetchUserInfo() // 🔥 유저 정보 가져오기
                }
            }
        } else {
            // ✅ 카카오계정 로그인
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print("❌ 카카오계정 로그인 실패: \(error)")
                } else {
                    print("✅ 카카오계정 로그인 성공")
                    fetchUserInfo() // 🔥 유저 정보 가져오기
                }
            }
        }
    }

    func fetchUserInfo() {
        UserApi.shared.me { user, error in
            if let error = error {
                print("❌ 사용자 정보 가져오기 실패: \(error)")
            } else {
                if let nickname = user?.kakaoAccount?.profile?.nickname {
                    print("✅ 로그인된 사용자 닉네임: \(nickname)")
                }
                if let email = user?.kakaoAccount?.email {
                    print("📧 이메일: \(email)")
                }
            }
        }
    }

}

// MARK: - 커스텀 텍스트 필드
struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeholder, text: $text, prompt: Text(placeholder).foregroundStyle(.customBlack))
                .font(.PretendardRegular13)
                .kerning(-0.65)
                .focused($isFocused)

            Divider()
                .background(isFocused ? Color.mainGreen : .gray)
                .padding(.top, -5)
        }
    }
}

#Preview {
    LoginView().environmentObject(NavigationRouter())
}

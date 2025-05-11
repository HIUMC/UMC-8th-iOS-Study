//
//  _025_UMC_iOSApp.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 3/19/25.
//

import SwiftUI
import KakaoSDKUser

struct LoginView: View {
    @State private var id = ""
    @State private var password = ""
    @FocusState private var isFocused: Bool
    
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(maxHeight: 104)
            
            Group {
                VStack(alignment: .leading) {
                    Image("Starbucks")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 97, height: 95)
                    
                    Spacer().frame(height: 28)
                    
                    Text("안녕하세요.\n스타벅스입니다.")
                        .font(.PretendardExtraBold24)
                        .foregroundStyle(Color.black)
                        .kerning(1.2)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer().frame(height: 19)
                    
                    Text("회원 서비스 이용을 위해 로그인 해주세요")
                        .font(.PretendardMedium16)
                        .foregroundStyle(Color.customGray1)
                        .kerning(-0.8)
                }
            }
            
            Spacer()
            
            Group {
                VStack(alignment: .leading, spacing: 47) {
                    CustomTextField(placeholder: "아이디", text: $id)
                    CustomTextField(placeholder: "비밀번호", text: $password)
                }
            }
            
            Spacer()
            
            Group {
                HStack {
                    Spacer()
                    VStack(spacing: 16) {
                        // ✅ signup 페이지로 네비게이션
                        NavigationLink(value: Route.signup) {
                            Text("이메일로 회원가입하기")
                                .font(.PretendardRegular12)
                                .underline()
                                .foregroundStyle(Color.customGray2)
                        }
                        
                        Button(action: {
                            kakaoLogin()
                        }) {
                            Image("kakaoLogin")
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
        }
        .padding(.horizontal, 19)
        .padding(.bottom, 62.4)
    }
    
    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print("❌ 카카오톡 로그인 실패:", error)
                } else if let token = oauthToken {
                    print("✅ 카카오톡 로그인 성공")
                    print("accessToken: \(token.accessToken)")
                    
                    // 👉 유저 정보 불러오기 (선택)
                    UserApi.shared.me { user, error in
                        if let error = error {
                            print("❌ 유저 정보 조회 실패:", error)
                        } else {
                            print("✅ 유저 정보:", user?.kakaoAccount?.email ?? "이메일 없음")
                        }
                        
                        DispatchQueue.main.async {
                            router.push(.home)
                        }
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print("❌ 카카오 계정 로그인 실패:", error)
                } else if let token = oauthToken {
                    print("✅ 카카오 계정 로그인 성공")
                    print("accessToken: \(token.accessToken)")

                    UserApi.shared.me { user, error in
                        if let error = error {
                            print("❌ 유저 정보 조회 실패:", error)
                        } else {
                            print("✅ 유저 정보:", user?.kakaoAccount?.email ?? "이메일 없음")
                        }

                        DispatchQueue.main.async {
                            router.push(.home)
                        }
                    }
                }
            }
        }
    }

}


/// 텍스트필드
struct CustomTextField: View {
   var placeholder: String
   @Binding var text: String
   @FocusState private var isFocused: Bool
   
   var body: some View {
       VStack(alignment: .leading) {
           TextField(placeholder, text: $text, prompt: Text(placeholder).foregroundStyle(Color.customBlack))
               .font(.PretendardRegular13)
               .kerning(-0.65)
               .focused($isFocused)
           
           Divider()
               .background(isFocused ? Color.mainGreen : Color.gray)
               .padding(.top, -5)
       }
   }
}

#Preview {
   LoginView()
       .environmentObject(NavigationRouter())
}

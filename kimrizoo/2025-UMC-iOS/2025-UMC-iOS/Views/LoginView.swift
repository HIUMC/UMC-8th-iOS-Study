import SwiftUI

struct LoginView: View {
    
    /// 변수 선언
    @State private var id = ""
    @State private var password = ""
    @FocusState private var isFocused: Bool
    
    @State private var router = NavigationRouter()
    
    /// 뷰
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack(alignment: .leading) {
                
                Spacer().frame(maxHeight: 104)
                
                /// 🔹 스타벅스 로고 및 텍스트
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
                
                /// 🔹 아이디 & 비밀번호 입력
                Group {
                    VStack(alignment: .leading, spacing: 47) {
                        CustomTextField(placeholder: "아이디", text: $id)
                        
                        CustomTextField(placeholder: "비밀번호", text: $password)
                    }
                }
                
                Spacer()
                
                /// 🔹 하단 회원가입 & 로그인 버튼
                Group {
                    HStack {
                        Spacer()
                        VStack(spacing: 16) {
                            Button(action: {
                                print("회원가입 버튼 클릭됨!")
                                router.push(.signup)
                                print("현재 path: \(router.path)") 
                            }) {
                                Text("이메일로 회원가입하기")
                                    .font(.PretendardRegular12)
                                    .underline()
                                    .foregroundStyle(Color.customGray2)
                            }
                            
                            Image("KakaoLogin")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 306, height: 45)
                            
                            Image("AppleLogin")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 306, height: 45)
                        } // VStack end
                        Spacer()
                    } // HStack end
                }
            }
            .padding(.horizontal, 19)
            .padding(.bottom, 62.4)
        } // 네비게이션
        .navigationDestination(for: Route.self) { route in
            switch route {
            case .signup:
                SignupView()
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
}

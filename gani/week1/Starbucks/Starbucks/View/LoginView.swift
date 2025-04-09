import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            VStack(alignment: .leading, spacing: 0) {
                Image(.starbucsLogo)
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
                    .foregroundColor(Color.gray1)
            }
            .padding(.leading, 24)
            .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 47) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("아이디")
                        .font(.custom("Pretendard-Regular", size: 13))
                    Divider()
                        .frame(width: 350)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("비밀번호")
                        .font(.custom("Pretendard-Regular", size: 13))
                    Divider()
                        .frame(width: 350)
                }
            }
            .padding()
            Button(action: {
                print("로그인 버튼 클릭")
            }) {
                Text("로그인하기")
                    .font(.custom("Pretendard-Medium", size: 16))
                    .foregroundColor(.white)
                    .frame(width: 382, height: 46)
                    .background(Color("green1"))
                    .cornerRadius(20)
            }

            Text("이메일로 회원가입하기")
                .font(.custom("Pretendard-Regular",size:12))
                .foregroundColor(.gray3)
                .underline()

            VStack(spacing: 19) {
                Image(.카카오로그인)
                Image(.애플로그인)
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}

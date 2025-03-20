import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            Spacer().frame(maxHeight: 104)
            
            /// 🔹 스타벅스 로고 및 텍스트
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
            
            
            Spacer()

            /// 🔹 아이디 & 비밀번호 입력
            VStack(alignment: .leading) {
                Text("아이디")
                    .font(.PretendardRegular13)
                    .foregroundStyle(Color.customBlack)
                    .kerning(-0.65)

                Divider()
                    .offset(y: -5)

                Spacer().frame(height: 47)
                
                Text("비밀번호")
                    .font(.PretendardRegular13)
                    .foregroundStyle(Color.customBlack)
                    .kerning(-0.65)

                Divider()
                    .offset(y: -5)
                
                Spacer().frame(height: 47)

                Button(action: {
                    print("로그인 버튼 클릭")
                }) {
                    GeometryReader { geometry in
                        Text("로그인하기")
                            .foregroundStyle(.white)
                            .frame(width: geometry.size.width, height: 46) // 부모 뷰의 크기만큼 확장
                            .background(Color.mainGreen)
                            .cornerRadius(20)
                    }
                }
                .frame(height: 46) // 높이 고정
            }

            Spacer()

            /// 🔹 하단 회원가입 & 로그인 버튼
            HStack {
                Spacer()
                
                VStack(spacing: 16) {
                    Text("이메일로 회원가입하기")
                        .font(.PretendardRegular12)
                        .underline()
                        .foregroundStyle(Color.customGray2)
                    
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
        .padding(.horizontal, 19)
        .padding(.bottom, 62.4)
        
    }
}

#Preview {
    LoginView()
}

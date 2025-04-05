import SwiftUI


struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @FocusState var focusField: Field?
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
    private var topView: some View {
        VStack(alignment: .leading) {
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
        .frame(maxWidth: 402, alignment: .leading)
        .padding(.leading, 19)
    }

    private var middleView: some View {
        VStack(spacing: 47) {
            VStack(alignment: .leading, spacing: 8) {
                
                TextField("아이디", text: $viewModel.id)
                    .font(.custom("Pretendard-Regular", size: 13))
                    .foregroundColor(Color.black)
                    .focused($focusField, equals: .id)
                Divider()
                    .frame(width: 350)
                    .background(focusField == .id ? Color("green1"): Color.gray.opacity(0.3))
            }
            .padding(.leading, 19)

            VStack(alignment: .leading, spacing: 8) {
                TextField("비밀번호", text: $viewModel.password)
                    .font(.custom("Pretendard-Regular", size: 13))
                    .focused($focusField, equals: .password)
                Divider()
                    .frame(width: 350)
                    .background(focusField == .password ? Color("green1") : Color.gray.opacity(0.3))
            }
            .padding(.leading, 19)
            Button(action: {
                print("로그인 버튼 클릭")
            }) {
                Text("로그인하기")
                    .font(.custom("Pretendard-Medium", size: 16))
                    .foregroundColor(.white)
                    .frame(width: 382, height: 46)
                    .background(Color("green1"))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }

        }
    }

    private var bottomView: some View {
        VStack(spacing: 19) {
            NavigationLink(destination: SignupView()) {
                Text("이메일로 회원가입하기")
                    .font(.custom("Pretendard-Regular", size: 12))
                    .foregroundColor(.gray3)
                    .underline()
            }

            VStack(spacing: 19) {
                Image(.kakao)
                Image(.apple)
            }
        }
    }
    
}
enum Field {
    case id
    case password
}

#Preview {
    LoginView()
}

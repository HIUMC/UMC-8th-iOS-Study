import SwiftUI

struct LoginView: View {
    @Binding var id: String
    @Binding var pwd: String

    @State private var showSignUp = false
    @FocusState private var focusedField: Field?
    
    enum Field {
        case userId, password
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            VStack(alignment: .leading, spacing: 20){
                Image("starbucks")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Text("안녕하세요.\n스타벅스입니다.")
                    .padding(.horizontal, 5)
                    .padding(.bottom, 20)
                    .fixedSize(horizontal: true, vertical: true)
                
                Text("회원 서비스 이용을 위해 로그인 해주세요")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
            .padding(.bottom, 130)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("아이디")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                TextField("", text: $id)
                    .focused($focusedField, equals: .userId)
                    .padding(.bottom, 4)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(focusedField == .userId ? .green : .gray),
                        alignment: .bottom
                    )
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("비밀번호")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                SecureField("", text: $pwd)
                    .focused($focusedField, equals: .password)
                    .padding(.bottom, 4)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(focusedField == .password ? .green : .gray),
                        alignment: .bottom
                    )
            }
        }
        .padding(.horizontal, 30)

        VStack(spacing: 20) {
            NavigationLink(destination: SignupView(), isActive: $showSignUp) {
                EmptyView()
            }

            Button {
                showSignUp = true
            } label: {
                Text("이메일로 회원가입하기")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .underline()
            }
            .padding(.vertical, 30)
            .padding(.top, 30)
            
     
            NavigationStack {
                NavigationLink(destination: SignupView()){
                    Button {
                     
                    } label: {
                        Text("이메일로 회원가입하기")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .underline()
                    }
                    .padding(.vertical, 30)
                    .padding(.top, 30)
                }
            }
            

         
            
     

            Image("kakaologin")
            Image("applelogin")
        }
        .padding(.horizontal, 30)

        Spacer()
    }
}


#Preview {
    LoginView(id: .constant(""), pwd: .constant(""))
}

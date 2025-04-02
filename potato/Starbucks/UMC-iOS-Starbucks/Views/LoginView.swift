//
//  LoginView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 3/30/25.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel: LoginViewModel = .init()
    @State private var router = NavigationRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                title
                
                Spacer()
                
                login
                
                Spacer()
                
                socialLogin
                    .navigationDestination(for: Route.self) {
                        value in
                        SignupView()
                    }
            }
            .padding(EdgeInsets(top: 104, leading: 19, bottom: 62.95, trailing: 19))
        }
    }
    
    private var title: some View {
        HStack {
            VStack(alignment: .leading, spacing: 28) {
                Image(.starbucksLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 97, height: 95)
                
                VStack(alignment: .leading, spacing: 19) {
                    Text("안녕하세요.\n스타벅스입니다.")
                        .font(.mainTextExtraBold24)
                        .kerning(1.2)
                        .foregroundStyle(Color("black00"))
                    
                    Text("회원 서비스 이용을 위해 로그인 해주세요")
                        .font(.mainTextMedium16)
                        .foregroundStyle(Color("gray01"))
                }
            }
            
            Spacer()
        }
    }
    
    @State private var id: String = ""
    @FocusState private var idFieldIsFocused: Bool
    @State private var pwd: String = ""
    @FocusState private var pwFieldIsFocused: Bool
    
    private var login: some View {
        VStack(spacing: 47) {
            VStack(alignment: .leading, spacing: 2) {
                TextField("아이디", text: $id, prompt: Text("아이디")
                    .foregroundColor(Color("black01"))
                    .font(.mainTextRegular13))
                .foregroundColor(Color("black01"))
                .font(.mainTextRegular13)
                .focused($idFieldIsFocused)
                
                Divider()
                    .background(idFieldIsFocused ? Color("green01") : Color("black01"))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                TextField("비밀번호", text: $pwd, prompt: Text("비밀번호").foregroundColor(Color("black01"))
                    .font(.mainTextRegular13))
                .foregroundColor(Color("black01"))
                .font(.mainTextRegular13)
                .focused($pwFieldIsFocused)
                
                Divider()
                    .background(idFieldIsFocused ? Color("green01") : Color("black01"))
            }
            
            Button(action: {
                print("로그인하기")
                // viewModel의 id, pwd와 textField에 입력한 값이 같은지 검사
                // -> viewModel에서 함수를 정의해야 할 듯
                // viewModel.login(id, pwd)
            }, label: {
                Text("로그인하기")
                    .font(.mainTextMedium16)
                    .foregroundStyle(Color("white01"))
                    .frame(maxWidth: .infinity, maxHeight: 46)
                    .background() {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("green01"))
                            .frame(height: 46)
                    }
            })
        }
    }
    
    private var socialLogin: some View {
        VStack(spacing: 19) {
            Button(action: {
                router.push(.signup)
            }, label: {
                Text("이메일로 회원가입하기")
                    .font(.mainTextRegular12)
                    .underline()
                    .foregroundStyle(Color("gray04"))
            })
            
            Image(.kakaoLogin)
            
            Image(.appleLogin)
        }
    }
}

#Preview("iPhone 16 Pro Max") {
    LoginView()
}

#Preview("iPhone 11") {
    LoginView()
}

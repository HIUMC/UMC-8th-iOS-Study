//
//  LoginView.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/23/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationStack{
            VStack() {
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
            }
        }
    }
    private var mainTitleGroup: some View {
        VStack(alignment: .leading) {
            Group {
                    Image(.starbuckLogo)
                    .resizable()
                    .frame(width: 97, height: 95)
                    .padding(.bottom,28)
                Text("안녕하세요.")
                    .font(.mainTextExtraBold24)
                Text("스타벅스입니다.")
                    .font(.mainTextExtraBold24)
                Text("회원 서비스 이용을 위해 로그인 해주세요.")
                    .font(.mainTextMedium16)
                    .foregroundStyle(Color.gray02)
                    .padding(.top)
            }
        }
    }
    
    
    private var mainMiddleGroup: some View {
        VStack(alignment: .leading) {
            
            LoginTextView()
           
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.green01)
                .frame(height: 46)
                .overlay(
                    Text("로그인하기")
                        .font(.mainTextMedium16)
                        .foregroundStyle(Color.white)
                )
        }
        .padding(.horizontal)
    }
    
    
    private var mainBottomGroup: some View {
                    VStack(alignment: .center){
                Group {
                    NavigationLink(destination: SignupView(signupViewModel: SignupViewModel())) {
                        Text("이메일로 회원가입하기")
                            .underline()
                            .font(.mainTextRegular12)
                            .foregroundStyle(Color.gray00)
                            .padding(.bottom, 19)
                    }
                        
                        
                        Image(.kakao)
                            .resizable()
                            .frame(width: 306, height: 45)
                            .padding(.bottom, 19)
                        
                        Image(.apple)
                            .resizable()
                            .frame(width: 306, height: 45)
                        
                    }
            }
    }
    
}



#Preview {
    LoginView()
}

struct LoginTextView: View {
    @StateObject var loginViewModel = LoginViewModel()
    @FocusState private var isID: Bool
    @FocusState private var isPwd: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            
                ZStack(alignment: .leading) {
                if loginViewModel.id.isEmpty {
                    Text("아이디")
                        .foregroundColor(.black)
                        .font(.mainTextRegular13)
                }
                TextField("", text: $loginViewModel.id)
                    .focused($isID)
                    .font(.mainTextRegular13)
                    .foregroundStyle(Color.black01)
            }
            Rectangle()
                .frame(height: 0.7)
                .foregroundStyle(isID ? Color.green01 : Color.gray00)
                .padding(.bottom, 47)
               

            ZStack(alignment: .leading) {
                if loginViewModel.pwd.isEmpty {
                    Text("비밀번호")
                        .foregroundColor(.black)
                        .font(.mainTextRegular13)
                }
                TextField("", text: $loginViewModel.pwd)
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


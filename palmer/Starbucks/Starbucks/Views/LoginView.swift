//
//  LoginView.swift
//  1st_work
//
//  Created by 박정환 on 3/22/25.
//

import SwiftUI
import Observation
import Foundation

struct LoginView: View {
    @FocusState private var focusedField: LoginField?
    @EnvironmentObject var router: NavigationRouter
    @ObservedObject var viewModel: LoginViewModel = .init()
    
    
    enum LoginField {
        case id
        case password
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            topTitle
                .padding(.top, 100)
            Spacer()
            idpassword
                .frame(height: 180)
            Spacer()
            loginSelection
                .frame(height: 144)
                .padding(.bottom, 60)
        }
        .onAppear {
            // 자동 로그인 체크
            autoLogin()
        }
    }
    
    private var topTitle: some View {
        HStack {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 97, height: 95)
                Spacer().frame(height: 28)
                Text("안녕하세요. \n스타벅스입니다.")
                    .foregroundStyle(.black)
                    .font(.mainTextExtraBold24)
                    .kerning(2)
                    .padding(.bottom, 10)
                Text("회원 서비스 이용을 위해 로그인 해주세요")
                    .foregroundStyle(Color("gray01"))
                    .font(.mainTextMedium16)
            }
            .padding(.leading, 20)
            Spacer()
        }
    }
    
    var idpassword: some View {
        VStack(alignment: .leading) {
            TextField("아이디", text: $viewModel.id)
                .focused($focusedField, equals: .id)
            
            Divider()
                .frame(height: 0.7)
                .background(focusedField == .id ? Color("green01") : Color("gray00"))
                .padding(.bottom, 47)
            
            SecureField("비밀번호", text: Binding(
                get: { viewModel.pwd },
                set: { viewModel.pwd = $0 }
            ))
                .focused($focusedField, equals: .password)
            
            Divider()
                .frame(height: 0.7)
                .background(focusedField == .password ? Color("green01") : Color("gray00"))
                .padding(.bottom, 47)
            
            Button(action: {
                print("로그인 버튼")
                // 실제 로그인 성공 시 토큰 저장
                let token = TokenInfo(accessToken: "abc123", refreshToken: "xyz456") // 실제 로그인 시 받은 값 사용
                KeychainService.shared.saveToken(token)
                print("토큰 저장 완료")
                router.push(.tabBar)
            }) {
                Text("로그인하기")
                    .font(.mainTextMedium16)
                    .foregroundStyle(.white)
                    .frame(maxWidth: 402, minHeight: 46)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("green01"))
                    )
                    .contentShape(Rectangle())
                    .background(Color.clear)
            }
        }
        .padding(.horizontal, 20)
    }
    
    private var loginSelection: some View {
        VStack {
            Button(action: { router.push(.signup)
            }, label: {
                Text("이메일로 회원가입하기")
                    .foregroundColor(Color("black01"))
                    .font(.mainTextRegular12)
                    .underline()
            })
            
            Image("kakaoLogin")
                .padding(.bottom, 19)
            
            Image("appleLogin")
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    private func autoLogin() {
        if KeychainService.shared.loadToken() != nil {
            print("자동 로그인 성공 - 토큰:", KeychainService.shared.loadToken())
            router.push(.tabBar)
        } else {
            print("자동 로그인 실패 - 저장된 토큰 없음")
        }
    }
}

struct LoginView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]

    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            LoginView(viewModel: LoginViewModel())
                .environmentObject(NavigationRouter())
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}

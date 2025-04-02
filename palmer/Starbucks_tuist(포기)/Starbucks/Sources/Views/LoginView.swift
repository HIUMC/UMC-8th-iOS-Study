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
    //@Environment(NavigationRouter.self) private var router
    @State private var router = NavigationRouter()
    @Bindable var viewModel : LoginViewModel
    
    enum LoginField {
        case id
        case password
    }
    
    
    var body: some View {
        NavigationStack(path: $router.path) {
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
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .signup:
                    SignupView(signupViewModel: SignupViewModel())
                }
            }
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
            
            SecureField("비밀번호", text: $viewModel.password)
                .focused($focusedField, equals: .password)
            
            Divider()
                .frame(height: 0.7)
                .background(focusedField == .password ? Color("green01") : Color("gray00"))
                .padding(.bottom, 47)
            
            Button(action: {
                print("로그인 버튼 클릭")
            }, label: {
                Text("로그인하기")
                    .font(.mainTextMedium16)
                    .foregroundStyle(.white)
                    .frame(maxWidth: 402, minHeight: 46)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("green01"))
                    )
            })
        }
        .padding(.horizontal, 20)
    }
    
    private var loginSelection: some View {
        VStack {
            Button(action: {
                router.push(.signup)
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
}
    
    struct LoginView_Preview: PreviewProvider {
        static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
        
        static var previews: some View {
            ForEach(devices, id: \.self) { device in
                LoginView(viewModel: LoginViewModel()) // viewModel 초기화 추가
                    .previewDevice(PreviewDevice(rawValue: device))
                    .previewDisplayName(device)
            }
        }
    }


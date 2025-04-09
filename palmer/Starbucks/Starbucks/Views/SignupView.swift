//
//  SignupView.swift
//  Starbucks
//
//  Created by 박정환 on 3/29/25.
//

import SwiftUI
import Observation

struct SignupView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var signupViewModel: SignupViewModel
    @State private var router = NavigationRouter()
    
    @AppStorage("nickname") private var storedNickname = ""
    @AppStorage("email") private var storedEmail = ""
    @AppStorage("password") private var storedPassword = ""
    
    var body: some View {
        NavigationStack(path: $router.path){
            VStack(alignment: .leading) {
                CustomNav(title: "가입하기", onBack: {
                    router.pop()  // router.pop()으로 뒤로가기
                })
                
                VStack(spacing:9){
                    TextField("닉네임", text: $signupViewModel.nickname)
                        .font(.mainTextRegular13)
                        .foregroundStyle(Color("black01"))
                    
                    Divider()
                    Spacer()
                    TextField("이메일", text: $signupViewModel.email)
                        .font(.mainTextRegular13)
                        .foregroundStyle(Color("black01"))
                    
                    Divider()
                    Spacer()
                    TextField("비밀번호", text: $signupViewModel.password)
                        .font(.mainTextRegular13)
                        .foregroundStyle(Color("black01"))
                    
                    Divider()
                }.frame(height:188)
                    .padding(.horizontal, 19)
                    .padding(.top, 210)
                
                Spacer()
                
                //생성 버튼
                Button(action: {
                    print("버튼 눌림")
                    if signupViewModel.nickname.count > 0 &&
                        signupViewModel.email.count > 0 &&
                        signupViewModel.password.count > 0 {
                        
                        storedNickname = signupViewModel.nickname
                        storedEmail = signupViewModel.email
                        storedPassword = signupViewModel.password
                        
                        router.pop()  // router.pop()으로 뒤로가기
                    } else {
                        print("모든 값을 한 글자 이상 입력해주세요!")
                    }
                }, label: {
                    Text("생성하기")
                        .font(.makeMedium18)
                        .foregroundStyle(.white)
                        .frame(maxWidth: 402, maxHeight: 58)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.green01)
                        )
                })
                .padding(.horizontal)
                .padding(.bottom, 72)
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .signup:
                    SignupView(signupViewModel: SignupViewModel())
                case .tabBar:
                    TabBarView()
                case .login:
                    LoginView(loginViewModel: LoginViewModel())
                case .coffeeDetail:
                    CoffeeDetailView(viewModel: HomeViewModel())
                }
            }
        }
    }
}


#Preview {
    SignupView(signupViewModel: SignupViewModel())
}

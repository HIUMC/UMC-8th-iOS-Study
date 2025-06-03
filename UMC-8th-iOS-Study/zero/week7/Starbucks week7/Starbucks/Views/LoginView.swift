//
//  LoginView.swift
//  Starbucks
//
//  Created by 김영택 on 3/21/25.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @ObservedObject var signupViewModel: SignupViewModel
    
    @FocusState private var isUserIDFocused : Bool
    @FocusState private var isPasswordFocused : Bool
    
    @State private var navigateToHome = false

    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print("카카오톡 로그인 실패:", error)
                } else {
                    print("카카오톡 로그인 success")
                    navigateToHome = true  // 화면 전환
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print("카카오 계정 로그인 실패:", error)
                } else {
                    print("카카오 계정 로그인 success")
                    navigateToHome = true  // 화면 전환
                }
            }
        }
    }

    var body: some View {
        
        Spacer().frame(height:104)
        
        NavigationStack {
            
            VStack (alignment: .leading) {
                VStack (alignment: .leading) {
                    Image(.starbucslogo)
                        .resizable()
                        .frame(width: 97, height: 95)
                    
                    Spacer().frame(height:28)
                    
                    Text("안녕하세요.\n스타벅스입니다.")
                        .font(.PretendardExtrabold24)
                        .foregroundStyle(Color.hello)
                    
                    Spacer().frame(height:19)
                    
                    Text("회원 서비스 이용을 위해 로그인 해주세요")
                        .font(.PretendarMedium16)
                        .foregroundStyle(Color.service)
                }//VStack1 End
                
                Spacer()
                
                VStack (alignment: .leading) {
                    
                    TextField("아이디", text: $viewModel.userID)
                        .font(.PretendardRegular13)
                        .foregroundStyle(Color.idpwd)
                        .focused($isUserIDFocused)
                    
                    
                    Divider()
                        .frame(height: 1)
                        .background(isUserIDFocused ? Color.login : Color.gray)
                    
                    Spacer().frame(height:47)
                    
                    TextField("비밀번호", text: $viewModel.password)
                        .font(.PretendardRegular13)
                        .foregroundStyle(Color.idpwd)
                        .focused($isPasswordFocused)
                    
                    Divider()
                        .frame(height: 1)
                        .background(isPasswordFocused ? Color.login : Color.gray)
                    
                    Spacer().frame(height:47)
                    
                    Button(action: {
                        viewModel.login()
                        
                        if viewModel.isLoginSuccess {
                            navigateToHome = true
                        }
                    }, label: {
                        Text("로그인하기")
                            .foregroundStyle(.tologin)
                            .frame(maxWidth: .infinity, maxHeight: 46)
                            .background(Color.login)
                            .cornerRadius(20)
                    })


                    //t로그인 결과 메시지 출력
                    if let message = viewModel.loginStatusMessage {
                        Text(message)
                            .foregroundColor(viewModel.isLoginSuccess ? .green : .red)
                            .font(.caption)
                            .padding(.top, 8)
                    }

                }//VStack2 End
                
                Spacer()
                
                HStack(){
                    Spacer()
                    
                    VStack() {
                        
                        NavigationLink(destination: SignupView(viewModel: signupViewModel)) {
                            Text("이메일 회원가입하기")
                                .font(.PretendardRegular12) 
                                .foregroundColor(Color.email)
                                .underline()
                        }

                        
                        Spacer().frame(height:19)
                        
                        Button(action: {
                        kakaoLogin()
                                print("kakaoLogin")
                        }, label:{
                            Image(.kakaologin)
                                .resizable()
                                .frame(width: 306, height: 45)
                        })
                        
                        Spacer().frame(height:19)
                        
                        Image(.applelogin)
                            .resizable()
                            .frame(width: 306, height: 45)
                        
                    }//VStack3 End
                    
                    Spacer()
                }//HStack End
                
                Spacer()
                
                NavigationLink(
                    destination: BottomTabView(),
                            isActive: $navigateToHome,
                            label: {
                                EmptyView()
                            }
                        )
            }//VStack_all End
        }
        .padding(.horizontal, 19)
     }
}

#Preview {
    LoginView(viewModel: LoginViewModel(),signupViewModel: SignupViewModel())  // 프리뷰에서 ViewModel 인스턴스 전달
}
            

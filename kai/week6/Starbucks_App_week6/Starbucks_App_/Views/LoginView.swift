//
//  LoginView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 3/20/25.
//

import SwiftUI
import KakaoSDKUser


struct LoginView: View {
    @Bindable var viewModel: LoginViewModel
    @Bindable var signupViewModel: SignupViewModel
    
    
    @FocusState private var isUserIDFocused : Bool
    @FocusState private var isPasswordFocused : Bool
    
    var body: some View {
        NavigationStack{
            Spacer().frame(height:104)
            
            VStack (alignment: .leading) {
                VStack (alignment: .leading) {
                    Image(.starbucks)
                        .resizable()
                        .frame(width: 97, height: 95)
                    
                    Spacer().frame(height:28)
                    
                    Text("안녕하세요.\n스타벅스입니다.")
                        .font(.PretendardExtraBold24)
                        .foregroundStyle(Color.logoblack)
                    
                    Spacer().frame(height:19)
                    
                    Text("회원 서비스 이용을 위해 로그인 해주세요")
                        .font(.PretendardMedium16)
                        .foregroundStyle(Color.userservice)
                }//VStack1 End
                
                Spacer()
                
                VStack (alignment: .leading) {
                    
                    TextField("아이디", text: $viewModel.userID)
                        .font(.PretendardRegular13)
                        .foregroundStyle(Color.idpwd)
                    
                    Divider()
                        .offset(y: -5)
                        .frame(height:2)
                        .background(isUserIDFocused ? Color.green : Color.gray)
                    
                    Spacer().frame(height:47)
                    
                    TextField("비밀번호", text: $viewModel.password)
                        .font(.PretendardRegular13)
                        .foregroundStyle(Color.idpwd)
                    
                    Divider()
                        .offset(y: -5)
                        .frame(height:2)
                        .background(isPasswordFocused ? Color.green : Color.gray)
                    
                    Spacer().frame(height:47)
                    
                    Button(action: {
                        viewModel.login()
                        print("로그인 버튼 클릭")
                    }) {
                        Text("로그인하기")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, minHeight: 46)
                            .background(Color.starbucksGreen)
                            .cornerRadius(20)
                    }
                }//VStack2 End
                
                Spacer()
                
                HStack(){
                    Spacer()
                    
                    VStack() {
                        NavigationLink("이메일로 회원가입하기",destination: SignupView(viewModel: signupViewModel))
                                .font(.PretendardRegular13)
                                .foregroundStyle(Color.gray)
                                .underline()
                                //밑줄이 안생김 ㅜㅜ
                        
                            
                        
                        Spacer().frame(height:19)
                        
                        Image(.kakaoLogin)
                            .resizable()
                            .frame(width: 306, height: 45)
                        
                        Spacer().frame(height:19)
                        
                        Image(.appleLogin)
                            .resizable()
                            .frame(width: 306, height: 45)
                        
                    }//VStack3 End
                    
                    Spacer()
                }//HStack End
                
                Spacer()
                
            }//VStack_all End
            
            .padding(.horizontal, 19)
            
            
        }//navigationStack_EMD
    }
}


func kakaoLogin() {
        // 카카오톡 실행 가능 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
           // 카카오톡 로그인
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                   print("카카오톡 로그인 success")

                   // 추가작업
                }
             }
         } else {
            // 카카오계정 로그인
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("카카오계정 로그인 success")

                                        // 추가작업
                }
            }
        }
    }

#Preview {
    LoginView(viewModel: LoginViewModel(), signupViewModel: SignupViewModel())
}
            

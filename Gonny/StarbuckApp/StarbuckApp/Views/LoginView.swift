//
//  LoginView.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/24/25.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct LoginView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @StateObject var userInfo: LoginViewModel
    @FocusState private var focusedField: Focusfield? //커서올리면 초록색 불 들어오게 해줘
    
    enum Focusfield{
        case id,pwd
    }
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
                
                topView
                    .padding(.top, 80)
                Spacer()
                MiddleView
                Spacer()
                BottomView
                
            }
            .padding(.horizontal,19 )
        }
    }
        private var topView: some View {
            VStack(alignment: .leading) {
                Group {
                    Image("starbuckLogo")
                        .resizable()
                        .frame(width: 97, height: 95)
                        .padding(.bottom, 28)
                    Text("안녕하세요.\n스타벅스입니다.")
                        .font(.mainTextBold24)
                        .foregroundColor(Color("black03"))
                        .padding(.bottom, 10)
                    Text("회원 서비스 이용을 위해 로그인 해주세요")
                        .font(.mainTextMedium16)
                        .foregroundColor(Color("gray01"))
                }
            }
        }
        
        //원래 버전
        private var MiddleView: some View {
            VStack(alignment: .leading) {
                VStack(spacing: 5){
                    //아이디입력
                    TextField("아이디", text: $userInfo.id)
                        .font(.mainTextRegular13)
                        .foregroundColor(Color("black01"))
                    //.padding(.bottom, 47)
                        .focused($focusedField, equals: .id)
                        .textFieldStyle(.plain)
                        .padding(.vertical,6)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(focusedField == .id ? Color("green01") : Color("gray02"))
                        .animation(.easeInOut(duration: 0.2), value: focusedField)
                }
                
                VStack(spacing:5){
                    //비밀번호 입력
                    TextField("비밀번호", text:$userInfo.pwd)
                        .font(.mainTextRegular13)
                        .foregroundColor(Color("black01"))
                        .focused($focusedField, equals: .pwd)
                        .textFieldStyle(.plain)
                        .padding(.vertical,6)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(focusedField == .pwd ? Color("green01") : Color("gray02"))
                        .animation(.easeInOut(duration: 0.2), value: focusedField)
                    
                    //Divider()
                    
                        .padding(.bottom, 47)
                    
                    Button(action: {
                        print("로그인 시도됨")
                        if userInfo.isValid(){
                            print("로그인 성공: isLoggedIn= true")
                            isLoggedIn=true
                        }
                        else {
                            print("로그인 실패: isValid()=false")
                            
                                         //if userInfo.isValid() {
                                          // isLoggedIn = true
                                       }
                                   }) {
                                       Text("로그인하기")
                                           .font(.mainTextMedium16)
                                           .foregroundColor(Color("white01"))
                                           .frame(maxWidth: .infinity, minHeight: 46)
                                           .background(Color("green01"))
                                           .cornerRadius(20)
                                   }
                }
            }
        }
        //NavigationLink(destination: SignupView())
        
        private var BottomView: some View {
            VStack {
                Group {
                    NavigationLink(destination: SignupView()) {
                        Text("이메일로 회원가입하기")
                            .font(.mainTextRegular13)
                            .underline()
                            .foregroundColor(Color("black01"))
                            .padding(.bottom, 19)
                    }
                    Button(action: {
                        if(UserApi.isKakaoTalkLoginAvailable()){
                            UserApi.shared.loginWithKakaoTalk{
                                (oauthToken, error) in if let error = error{
                                    print(error)
                                } else {
                                    print("카카오톡 로그인 성공")
                                    isLoggedIn = true
                                }
                                
                            }
                        } else {
                            UserApi.shared.loginWithKakaoAccount{
                                (oauthToken, error) in
                                if let error = error {
                                    print(error)
                                }
                                else{
                                    print("카카오 계정 로그인 성공")
                                    isLoggedIn = true
                                }
                            }
                        }
                    }) {
                                    Image("kakaoLogin")
                                        .resizable()
                                        .frame(width: 306, height: 45)
                                }
                                .padding(.bottom, 19)

                    Image("appleLogin")
                        .frame(width: 306, height: 45)
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}


#Preview {
    LoginView(userInfo: LoginViewModel())
}



//
//  LoginView.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/24/25.
//

import SwiftUI

struct LoginView: View {
    @Bindable var userInfo: LoginViewModel
 
    var body: some View {
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
            Group {
                //아이디입력
                TextField("아이디", text: $userInfo.id)
                    .font(.mainTextRegular13)
                    .foregroundColor(Color("black01"))
                    .padding(.bottom, 47)
                //비밀번호 입력
                TextField("비밀번호", text:$userInfo.pwd)
                    .font(.mainTextRegular13)
                    .foregroundColor(Color("black01"))
                //Divider()
                    .padding(.bottom, 47)
                
                //로그인버튼
                Rectangle()
                    .fill(Color("green01"))
                    .frame(width: 402, height: 46)
                    .cornerRadius(20)
                    .overlay(
                        Text("로그인하기")
                            .font(.mainTextMedium16)
                            .foregroundColor(Color("white01"))
                    )
            }
        }
    }
    
    /*지피티 코든데 안되냐 ㅗㅗㅗ
     private var MiddleView: some View {
        VStack(alignment: .leading, spacing: 47) {
            TextField("아이디", text: $userInfo.id)
                .font(.mainTextRegular13)
                .foregroundColor(Color("black01"))

            TextField("비밀번호", text: $userInfo.pwd)
                .font(.mainTextRegular13)
                .foregroundColor(Color("black01"))

            Rectangle()
                .fill(Color("green01"))
                .frame(width: 402, height: 46)
                .cornerRadius(20)
                .overlay(
                    Text("로그인하기")
                        .font(.mainTextMedium16)
                        .foregroundColor(Color("white01"))
                )
        }
    }
    */
    
    private var BottomView: some View {
        VStack {
            Group {
                Text("이메일로 회원가입하기")
                    .font(.mainTextRegular13)
                    .underline()
                    .foregroundColor(Color("black01"))
                    .padding(.bottom, 19)
                Image("kakaoLogin")
                    .frame(width: 306, height: 45)
                    .padding(.bottom, 19)
                Image("appleLogin")
                    .frame(width: 306, height: 45)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    LoginView(userInfo: LoginViewModel())
}

//이건 진짜 어디서 오류가 나는 건지 모르겠다!!!!!!!!!!!

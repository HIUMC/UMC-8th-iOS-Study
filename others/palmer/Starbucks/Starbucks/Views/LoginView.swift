//
//  LoginView.swift
//  1st_work
//
//  Created by 박정환 on 3/22/25.
//

import SwiftUI


struct LoginView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            topTitle
                .padding(.top, 80)
            Spacer()
            idpwd
            Spacer()
            
            loginSelection
        }
        .padding(.leading, 19) // 양 옆에 19px 여백
        .padding(.trailing, 19) // 양 옆에 19px 여백
    }
    
    private var topTitle: some View {
        VStack(alignment: .leading) {
            Group {
                Image("logo")
                    .resizable()
                    .frame(width: 97, height: 95)
                    .padding(.bottom, 28)
                Text("안녕하세요.\n스타벅스입니다.")
                    .font(.mainTextExtraBold24)
                    .foregroundColor(Color("black03"))
                    .padding(.bottom, 10)
                Text("회원 서비스 이용을 위해 로그인 해주세요")
                    .font(.mainTextMedium16)
                    .foregroundColor(Color("gray01"))
            }
        }
    }
    
    private var idpwd: some View {
        VStack(alignment: .leading) {
            Group {
                Text("아이디")
                    .font(.mainTextRegular13)
                    .foregroundColor(Color("black01"))
                Divider()
                    .padding(.bottom, 47)
                Text("비밀번호")
                    .font(.mainTextRegular13)
                    .foregroundColor(Color("black01"))
                Divider()
                    .padding(.bottom, 47)
                Rectangle()
                    .fill(Color("green01"))
                    .frame(width: 402, height: 46)
                    .cornerRadius(20)
                    .overlay(
                        Text("로그인하기")
                            .font(.mainTextMedium16)
                            .foregroundColor(.white)
                    )
            }
        }
    }
    
    private var loginSelection: some View {
        VStack {
            Group {
                Text("이메일로 회원가입하기")
                    .font(.mainTextRegular13)
                    .underline()
                    .foregroundColor(Color("black01"))
                    .padding(.bottom, 19)
                Image("kakaoLogin") // 이미지 리소스 이름을 올바르게 수정
                    .padding(.bottom, 19)
                Image("appleLogin") // 이미지 리소스 이름을 올바르게 수정
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}



//preview
struct LoginView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            LoginView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}



//
//  LoginView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/22/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            topView
                .padding(.top, 100)
            Spacer()
            middleView
                .frame(height: 180)
            Spacer()
            bottomView
                .frame(height: 144)
                .padding(.bottom, 60)
        }
    }
}

private var topView: some View {
    HStack {
        VStack(alignment: .leading) {
            Image("logo")
                .resizable()
                .frame(width: 97, height: 95)
            Spacer().frame(height: 28)
            Text("안녕하세요. \n스타벅스입니다.")
                .foregroundStyle(.black)
                .font(.MainTextExtraBold24)
                .kerning(2)
                .padding(.bottom, 10)
            Text("회원 서비스 이용을 위해 로그인 해주세요")
                .foregroundStyle(.gray01)
                .font(.MainTextMedium16)
                .kerning(-1)
                
        }
        .padding(.leading, 20)
        Spacer()
    }
    
}

private var middleView: some View {
    let labels = ["아이디", "비밀번호"]
    return VStack(alignment: .center, spacing: 47) {
        ForEach(labels, id: \.self) { label in
            VStack(alignment: .leading) {
                Text(label)
                    .font(.MainTextRegular13)
                    .foregroundStyle(.black01)
                    .padding(.leading, 20)
                Divider()
                    .frame(height: 0.7)
                    .overlay(.gray00)
                    .padding([.horizontal], 20)
            }
        }
        Button(action:  {
            print("로그인 버튼 클릭됨")
        }, label: {
            Text("로그인하기")
                .foregroundStyle(.white)
                .font(.MainTextMedium16)
                .frame(maxWidth: .infinity, minHeight: 46)
                .background(.green01)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        })
        .padding([.horizontal], 20)
    }
}

private var bottomView: some View {
    VStack {
        Button(action: {
            print("이메일로 회원가입하기 눌림")
        }, label: {
            Text("이메일로 회원가입하기")
                .font(.MainTextRegular12)
                .foregroundStyle(.gray04)
                .underline(true, color: .gray04)
        })
        
        Spacer()
        
        Button(action: {
            print("카카오 로그인 클릭됨")
        }) {
            HStack {
                Image("kakaoLogo")
                    .padding(.leading, 20)
                Spacer()
            }
            .overlay(alignment: .center, content: {
                Text("카카오 로그인")
                    .foregroundStyle(.black.opacity(0.85))
                    .font(.MainTextMedium16)
            })
            .frame(width: 306, height: 45)
            .background(Color(hex: "FEE500"))
            .clipShape(RoundedRectangle(cornerRadius: 5))
        }
        
        Spacer()
        
        Button(action: {
            print("애플 로그인 클릭됨")
        }) {
            HStack {
                Image("appleLogo")
                    .padding(.leading, 20)
                Spacer()
            }
            .overlay(alignment: .center, content: {
                Text("Apple로 로그인")
                    .foregroundStyle(.white)
                    .font(.MainTextMedium16)
            })
            .frame(width: 306, height: 45)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
    
}



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

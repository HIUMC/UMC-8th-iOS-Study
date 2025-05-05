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
    var viewModel : LoginViewModel = .init()
    
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
    
    var topTitle: some View {
        VStack(alignment: .leading) {
            Group {
                Image("logo")
                    .resizable()
                    .frame(width: 97, height: 95)
                    .padding(.bottom, 28)
                Text("안녕하세요.\n스타벅스입니다.")
                    .font(.system(size: 24, weight: .heavy))
                    .foregroundColor(Color("black03"))
                    .padding(.bottom, 10)
                Text("회원 서비스 이용을 위해 로그인 해주세요")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color("gray01"))
            }
        }
    }
    
    var idpwd: some View {
        VStack(alignment: .leading) {
                TextField("아이디", text: $viewModel.id)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.vertical, 10)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(viewModel.isFocusedId ? Color("green01") : Color.gray),
                        alignment: .bottom
                    )
                    .onTapGesture {
                        viewModel.isFocusedId = true
                        viewModel.isFocusedPassword = false
                    }
                    .padding(.bottom, 47)
                
                // 비밀번호 텍스트 필드
                TextField("비밀번호", text: $viewModel.password)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.vertical, 10)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(viewModel.isFocusedPassword ? Color("green01") : Color.gray),
                        alignment: .bottom
                    )
                    .onTapGesture {
                        viewModel.isFocusedId = false
                        viewModel.isFocusedPassword = true
                    }
                    .padding(.bottom, 47)
                
                // 로그인 버튼
                Button(action: {
                    print("로그인 버튼 클릭")
                }, label: {
                    Text("로그인하기")
                        .font(.mainTextMedium16)
                        .foregroundStyle(.white)
                        .frame(maxWidth: 402, maxHeight: 46)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.green01)
                        )
                })
        }
    }
    
    private var loginSelection: some View {
        VStack {
            Group {
                Text("이메일로 회원가입하기")
                    .font(.system(size: 13, weight: .regular))
                    .underline()
                    .foregroundColor(Color("black01"))
                    .padding(.bottom, 19)
                
                Image("kakaoLogin")
                    .padding(.bottom, 19)
                
                Image("appleLogin")
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            LoginView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}

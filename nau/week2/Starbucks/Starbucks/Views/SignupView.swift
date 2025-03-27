//
//  SignupView.swift
//  Starbucks
//
//  Created by nau on 3/25/25.
//

import SwiftUI

struct SignupView: View {
    @StateObject var viewModel:  SignupViewModel
    
    //TextField에 값 입력하면 이 지역 변수 값이 바뀌고 생성하기 버튼을 누르면 뷰모델의 nickname, email, pwd에 이 지역 변수의 값이 주입된다.
    @State private var nickname = ""
    @State private var email = ""
    @State private var pwd = ""

    var body: some View {
        VStack {
            textFieldView
            
            Spacer().frame(maxHeight: 400)
            
            Btn
        }.padding(.horizontal, 19)
            .offset(y: 30)
    }
    
    private var textFieldView: some View {
        VStack() {
            TextField("닉네임", text: $nickname)
            Divider()
            
            Spacer().frame(maxHeight: 49)
            
            TextField("이메일", text: $email)
            Divider()
            
            Spacer().frame(maxHeight: 49)
            
            TextField("비밀번호", text: $pwd)
            Divider()
        }
    }
    
    private var Btn: some View {
        Button(action: {
            viewModel.createAccount(from: SignupModel(nickname: nickname, email: email, pwd: pwd))
        }, label: {
            Image(.createBtn)
                .resizable()
                .scaledToFit()
        })
    }
}

#Preview {
    SignupView(viewModel: SignupViewModel())
}

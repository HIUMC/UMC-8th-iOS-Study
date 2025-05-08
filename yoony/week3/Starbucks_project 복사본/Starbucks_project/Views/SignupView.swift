//
//  SignupView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 3/26/25.
//

import SwiftUI

struct SignupView: View {


    @StateObject private var viewModel = SignupViewModel()
    
    var body: some View {
        
        VStack (alignment: .leading){
            
            Spacer().frame(height: 140)
            
            Text("닉네임")
                .font(.mainTextRegular18)
                .foregroundColor(.grey02)
            
            TextField("", text: $viewModel.name)
                .font(.mainTextRegular9)
                .foregroundColor(.black01)
                            
            Divider()
                .background(Color.grey00)
                .offset(y: -20)
            
            Spacer().frame(height: 49)
            
            Text("이메일")
                .font(.mainTextRegular18)
                .foregroundColor(.grey02)
            
            TextField("", text: $viewModel.email)
                .font(.mainTextRegular9)
                .foregroundColor(.black01)
            
            Divider()
                .background(Color.grey00)
                .offset(y: -20)
            
            Spacer().frame(height: 49)
            
            Text("비밀번호")
                .font(.mainTextRegular18)
                .foregroundColor(.grey02)
            
            TextField("", text: $viewModel.password)
                .font(.mainTextRegular9)
                .foregroundColor(.black01)
            
            Divider()
                .background(Color.grey00)
                .offset(y: -20)
            
            Spacer().frame(height: 310)
            
            Button(action:{viewModel.saveUserInfo()}
            ){
                Image(.generatebutton)
                    .resizable()
                    .scaledToFit()
            }
                
            
        } .padding(.horizontal, 19)
    }
}

#Preview {
    SignupView()
}

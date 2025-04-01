//
//  SignupView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 3/27/25.
//

import SwiftUI

struct SignupView: View {
    @Bindable var viewModel: SignupViewModel
    
    @AppStorage("newID") var newID: String = ""
    @AppStorage("email") var email: String = ""
    @AppStorage("newPassword") var newPassword: String = ""
    var body: some View {
        
        
        VStack{
            
            
            TextField("닉네임",text: $viewModel.newID)
                .font(.PretendardMedium16)
                .foregroundStyle(Color.gray)
            
            Divider()
            Spacer().frame(height:49)
            
            TextField("이메일",text: $viewModel.email)
                .font(.PretendardMedium16)
                .foregroundStyle(Color.gray)
            
            Divider()
            Spacer().frame(height:49)

            
            TextField("비밀번호",text: $viewModel.newPassword)
                .font(.PretendardMedium16)
                .foregroundStyle(Color.gray)
            
            Divider()
            
            Spacer()
            
            Image(.createbutton)
                .resizable()
                .scaledToFit()
            
        }//VStack_end
        .padding(.horizontal,19)
        .padding(.vertical,72)
        
    }
}

#Preview {
    SignupView(viewModel:SignupViewModel())
}


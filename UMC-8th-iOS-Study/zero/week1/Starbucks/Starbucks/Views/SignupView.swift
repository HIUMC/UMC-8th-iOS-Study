//
//  SignupView.swift
//  Starbucks
//
//  Created by 김영택 on 3/26/25.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var viewModel: SignupViewModel

    var body: some View {
        
        
        VStack{
            
            Spacer()
            
            TextField("닉네임",text: $viewModel.newID)
                .font(.PretendarMedium16)
                .foregroundStyle(Color.gray)
            
            Divider()
            Spacer().frame(height:49)
            
            TextField("이메일",text: $viewModel.email)
                .font(.PretendarMedium16)
                .foregroundStyle(Color.gray)
            
            Divider()
            Spacer().frame(height:49)

            
            TextField("비밀번호",text: $viewModel.newPassword)
                .font(.PretendarMedium16)
                .foregroundStyle(Color.gray)
            
            Divider()
            
            Spacer().frame(height:350)
            
            Button(action: {
                            viewModel.saveAppStorage()
            }, label: {
                Text("생성하기")
                    .font(.PretendarMedium16)
                    .foregroundStyle(.white)
                    .frame(maxWidth: 402, maxHeight: 58)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.login)
                    )
            })
            
            
            
        }//VStack_end
        .padding(.horizontal,19)
        .padding(.vertical,45)
        
    }
}

#Preview {
    SignupView(viewModel:SignupViewModel())
}





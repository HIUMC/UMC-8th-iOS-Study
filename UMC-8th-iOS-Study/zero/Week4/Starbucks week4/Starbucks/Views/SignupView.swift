//
//  SignupView.swift
//  Starbucks
//
//  Created by 김영택 on 3/26/25.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var viewModel: SignupViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Spacer().frame(height:40)
            HStack {
                Button(action: {dismiss}){
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.black)
                        .font(.PretendardSemibold16)
                    Spacer().frame(width:135)
                    Text("가입하기")
                        .font(.PretendarMedium16)
                        .foregroundStyle(.black)
                    
                }
            }.padding(.trailing,150)
                .frame(width:700)
            
            Spacer().frame(height:130)
            
            TextField("닉네임",text: $viewModel.newID)
                .font(.PretendarMedium16)
                .foregroundStyle(Color.gray)
                .padding(.leading)
            
            Divider()
            Spacer().frame(height:49)
            
            TextField("이메일",text: $viewModel.email)
                .font(.PretendarMedium16)
                .foregroundStyle(Color.gray)
                .padding(.leading)
            
            Divider()
            Spacer().frame(height:49)
            
            
            TextField("비밀번호",text: $viewModel.newPassword)
                .font(.PretendarMedium16)
                .foregroundStyle(Color.gray)
                .padding(.leading)
            
            Divider()
            
            Spacer().frame(height:350)
            
            Button(action: {
                if !viewModel.newID.isEmpty && !viewModel.email.isEmpty && !viewModel.newPassword.isEmpty {
                    dismiss()
                    viewModel.saveAppStorage()
                }
            }, label: {
                Text("생성하기")
                    .font(.PretendarMedium16)
                    .foregroundStyle(.white)
                    .frame(width: 370, height: 58)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.login)
                    )
            })
            Spacer().frame(height:72)
            
                .disabled(viewModel.newID.isEmpty || viewModel.email.isEmpty || viewModel.newPassword.isEmpty)
        }//VStack_end
    }
}

#Preview {
    SignupView(viewModel:SignupViewModel())
}





//
//  SignupView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 3/26/25.
//

import SwiftUI

struct SignupView: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SignupViewModel()
    @FocusState private var isNameFocused: Bool
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    
    @AppStorage("savedEmail") var savedEmail: String = ""
    @AppStorage("savedPassword") var savedPassword: String = ""
    
    var body: some View {
        

                
                HStack{
                    
                    Button(action: {dismiss()}){
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black01)
                            .font(.mainTextSemiBold16)
                            .offset(x: 26)
                        
                        Text("                                          가입하기")
                                .foregroundColor(.black01)
                                .font(.mainTextSemiBold16)

                    }
                    .navigationBarBackButtonHidden(true)
                    Spacer()
                }
        
        
        
            VStack (alignment: .leading){
                
                ///CustomNavigationBar(title: "회원가입", onBack: { dismiss() })
                
                Spacer().frame(height: 140)
                
                Text("닉네임")
                    .font(.mainTextRegular18)
                    .foregroundColor(.grey02)
                
                TextField("", text: $viewModel.name)
                    .font(.mainTextRegular9)
                    .foregroundColor(.black01)
                    .focused($isNameFocused)
                                    
                Divider().background(isNameFocused ? Color.green01 : Color.grey00)
                
                Spacer().frame(height: 49)
                
                Text("이메일")
                    .font(.mainTextRegular18)
                    .foregroundColor(.grey02)
                
                TextField("", text: $viewModel.email)
                    .font(.mainTextRegular9)
                    .foregroundColor(.black01)
                    .focused($isEmailFocused)
                                    
                Divider().background(isEmailFocused ? Color.green01 : Color.grey00)
                
                
                Spacer().frame(height: 49)
                
                Text("비밀번호")
                    .font(.mainTextRegular18)
                    .foregroundColor(.grey02)
                
                TextField("", text: $viewModel.password)
                    .font(.mainTextRegular9)
                    .foregroundColor(.black01)
                    .focused($isPasswordFocused)
                                    
                Divider().background(isPasswordFocused ? Color.green01 : Color.grey00)
                
                Spacer().frame(height: 310)
                
                Button(action:{
                    if !viewModel.name.isEmpty && !viewModel.email.isEmpty && !viewModel.password.isEmpty {
                        viewModel.saveUserInfo()
                        dismiss()
                    }
                }){
                    Image(.generatebutton)
                        .resizable()
                        .scaledToFit()
                    
                }
                
                
            }   .padding(.horizontal, 19)
                
                
        }
    }


#Preview {
    SignupView()
}

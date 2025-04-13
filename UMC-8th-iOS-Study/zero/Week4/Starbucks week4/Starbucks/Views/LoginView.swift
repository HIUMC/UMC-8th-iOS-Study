//
//  LoginView.swift
//  Starbucks
//
//  Created by 김영택 on 3/21/25.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @ObservedObject var signupViewModel: SignupViewModel
    
    @FocusState private var isUserIDFocused : Bool
    @FocusState private var isPasswordFocused : Bool
    
    var body: some View {
        
        Spacer().frame(height:104)
        
        NavigationStack {
            
            VStack (alignment: .leading) {
                VStack (alignment: .leading) {
                    Image(.starbucslogo)
                        .resizable()
                        .frame(width: 97, height: 95)
                    
                    Spacer().frame(height:28)
                    
                    Text("안녕하세요.\n스타벅스입니다.")
                        .font(.PretendardExtrabold24)
                        .foregroundStyle(Color.hello)
                    
                    Spacer().frame(height:19)
                    
                    Text("회원 서비스 이용을 위해 로그인 해주세요")
                        .font(.PretendarMedium16)
                        .foregroundStyle(Color.service)
                }//VStack1 End
                
                Spacer()
                
                VStack (alignment: .leading) {
                    
                    TextField("아이디", text: $viewModel.userID)
                        .font(.PretendardRegular13)
                        .foregroundStyle(Color.idpwd)
                        .focused($isUserIDFocused)
                    
                    
                    Divider()
                        .frame(height: 1)
                        .background(isUserIDFocused ? Color.login : Color.gray)
                    
                    Spacer().frame(height:47)
                    
                    TextField("비밀번호", text: $viewModel.password)
                        .font(.PretendardRegular13)
                        .foregroundStyle(Color.idpwd)
                        .focused($isPasswordFocused)
                    
                    Divider()
                        .frame(height: 1)
                        .background(isPasswordFocused ? Color.login : Color.gray)
                    
                    Spacer().frame(height:47)
                    
                    Button(action: {
                        viewModel.login()
                        print("로그인 버튼 클릭")
                    }, label: {
                        Text("로그인하기")
                            .foregroundStyle(.tologin)
                            .frame(maxWidth: .infinity, maxHeight: 46)
                            .background(Color.login)
                            .cornerRadius(20)
                    })
                }//VStack2 End
                
                Spacer()
                
                HStack(){
                    Spacer()
                    
                    VStack() {
                        
                        NavigationLink(destination: SignupView(viewModel: signupViewModel)) {
                            Text("이메일 회원가입하기")
                                .font(.PretendardRegular12) 
                                .foregroundColor(Color.email)
                                .underline()
                        }

                        
                        Spacer().frame(height:19)
                        
                        Image(.kakaologin)
                            .resizable()
                            .frame(width: 306, height: 45)
                        
                        Spacer().frame(height:19)
                        
                        Image(.applelogin)
                            .resizable()
                            .frame(width: 306, height: 45)
                        
                    }//VStack3 End
                    
                    Spacer()
                }//HStack End
                
                Spacer()
                
            }//VStack_all End
        }
      
        .padding(.horizontal, 19)


     }
}

#Preview {
    LoginView(viewModel: LoginViewModel(),signupViewModel: SignupViewModel())  // 프리뷰에서 ViewModel 인스턴스 전달
}
            

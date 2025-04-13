//
//  LoginView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 3/20/25.
//

import Foundation
import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @FocusState private var isIDFocused : Bool
    @FocusState private var isPWFocused : Bool
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("savedEmail") var savedEmail: String = "Yys"
    @AppStorage("savedPassword") var savedPassword: String = "0630"
    @State private var navigate = false
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
                Image(.starbuckslogo)
                    .resizable()
                    .frame(width: 97, height: 95)
                
                Spacer().frame(height: 28)
                
                Text("안녕하세요. \n스타벅스입니다.")
                    .font(.mainTextExtraBold24)
                    .foregroundColor(.black01)
                    .fixedSize(horizontal: false, vertical: true)
                    
                
                Spacer().frame(height: 19)
                
                Text("회원 서비스 이용을 위해 로그인 해주세요")
                    .font(.mainTextMedium16)
                    .foregroundColor(.grey01)
                
                Spacer().frame(height: 104)
                
                
                Text("아이디")
                    .font(.mainTextRegular13)
                    .foregroundColor(.black01)
                
                TextField("", text: $viewModel.ID)
                    .font(.mainTextRegular9)
                    .foregroundColor(.black01)
                    .focused($isIDFocused)
                
                Divider().background(isIDFocused ? Color.green01 : Color.grey00)
                
                Spacer().frame(height: 47)
                
                Text("비밀번호")
                    .font(.mainTextRegular13)
                    .foregroundColor(.black01)
                
                TextField("", text: $viewModel.PW)
                    .font(.mainTextRegular9)
                    .foregroundColor(.black01)
                    .focused($isPWFocused)
                
                Divider().background(isPWFocused ? Color.green01 : Color.grey00)
                
                Spacer().frame(height: 47)
                
                
                
                
            }.padding(.horizontal, 19)
            
            Button(action: {
                if viewModel.ID == savedEmail && viewModel.PW == savedPassword {
                    isLoggedIn = true
                    navigate = true
                }
            }){
                Image(.loginimage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 370, height: 46)
                    .padding(.horizontal, 19)
            }
         
                
                Spacer().frame(height: 104)
                
            
            
            VStack {
                
                VStack{
                    
                    NavigationLink(destination: SignupView()) {
                        
                        Text("이메일로 회원가입하기")
                            .font(.mainTextRegular12)
                            .foregroundColor(.grey04)
                            .underline()
                            .baselineOffset(2)
                    }
                    
                    Spacer().frame(height: 19)
                    
                    Image(.loginframe1)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 306, height: 45)
                    
                    Spacer().frame(height: 19)
                    
                    Image(.loginframe2)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 306, height: 45)
                }
                .navigationDestination(isPresented: $navigate){
                        TabBarView()
                    }
                }
            }
        }
    }


#Preview {
    LoginView()
}

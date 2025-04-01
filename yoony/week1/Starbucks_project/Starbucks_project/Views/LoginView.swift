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
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(.starbuckslogo)
                .resizable()
                .frame(width: 97, height: 95)
            
            Spacer().frame(height: 28)
            
            Text("안녕하세요. \n스타벅스입니다.")
                .font(.mainTextExtraBold24)
                .foregroundColor(.black01)
            
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
        
        ZStack {
            Image(.loginimage)
                .resizable()
                .scaledToFit()
            
            Text("로그인")
                .font(.mainTextMedium16)
                .foregroundColor(.white1)
            
            Spacer().frame(height: 104)
            
        }.padding(.horizontal, 19)
        
        VStack {
            
            Text("이메일로 회원가입하기")
                .font(.mainTextRegular12)
                .foregroundColor(.grey04)
                .underline()
                .baselineOffset(2)
            
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
        
    }
}

#Preview {
    LoginView()
}

//
//  LoginView.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/23/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack() {
            Spacer().frame(height: 104)
            mainTitleGroup
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            Spacer()
            mainMiddleGroup
            Spacer()
            mainBottomGroup
                .frame(maxWidth: .infinity)
            Spacer()
        }
        
        
    }
        
    
    
    private var mainTitleGroup: some View {
        VStack(alignment: .leading) {
            Group {
                    Image(.starbuckLogo)
                    .resizable()
                    .frame(width: 97, height: 95)
                    .padding(.bottom,28)
                Text("안녕하세요.")
                    .font(.mainTextExtraBold24)
                Text("스타벅스입니다.")
                    .font(.mainTextExtraBold24)
                Text("회원 서비스 이용을 위해 로그인 해주세요.")
                    .font(.mainTextMedium16)
                    .foregroundStyle(Color.gray02)
                    .padding(.top)
                    
            }
            
        }
        
        
    }
    
    private var mainMiddleGroup: some View{
        VStack(alignment: .leading) {
            Group {
            
                Text("아이디")
                    .font(.mainTextRegular13)
                    .foregroundStyle(Color.black01)
                Divider()
                    .padding(.bottom,47)
                
                Text("비밀번호")
                    .font(.mainTextRegular13)
                    .foregroundStyle(Color.black01)
                Divider()
                    .padding(.bottom,47)
                
                ZStack() {
                    Group{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.green01)
                            .frame(height: 46)
                        Text("로그인하기")
                            .font(.mainTextMedium16)
                            .foregroundStyle(Color.white)
                        
                    }
                
                }
                
            }
            
        }
        .padding(.horizontal)
      
    }
    
    private var mainBottomGroup: some View {
        VStack(alignment: .center){
            Group {
                Text("이메일로 회원가입하기")
                    .underline()
                    .font(.mainTextRegular12)
                    .foregroundStyle(Color.gray00)
                    .padding(.bottom, 19)
                
                
                Image(.kakao)
                    .resizable()
                    .frame(width: 306, height: 45)
                    .padding(.bottom, 19)
                
                Image(.apple)
                    .resizable()
                    .frame(width: 306, height: 45)
                
            }
        }
    }
    
}

#Preview {
    LoginView()
}


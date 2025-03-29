//
//  LoginViews.swift
//  Starbucks_Week1_gogo
//
//  Created by 고석현 on 3/24/25.
//


import SwiftUI

struct LoginView: View {
    var body: some View {
            VStack(alignment: .leading) {
                Spacer().frame(height: 100)
                topSection
                Spacer()
                midSection
                Spacer()
                bottomSection

        }
        .padding(.horizontal, 19)
        
    }
}


private var topSection: some View {
    VStack(alignment: .leading) {
        Image("miniLogo")
            .resizable()
            .frame(width: 97, height: 95)
            .aspectRatio(contentMode: .fit)
        
        Spacer().frame(height: 28)
        
        
            Text("안녕하세요.\n스타벅스입니다.")
            
        
            .font(.PretendardExtraBold24)
            .foregroundStyle(Color.black)
            

        
        Spacer().frame(height: 19)
        
        Text("회원 서비스 이용을 위해 로그인 해주세요")
            .font(.PretendardMedium16)
            .foregroundStyle(Color.gray01)
            
        
        
        
    }
}


private var midSection: some View {
    VStack(alignment: .leading) {
        Text("아이디")
            .font(.PretendardRegular13)
            .foregroundStyle(.black)
            
        
        Spacer().frame(height: 1.98)
        
        Divider()
        
        Spacer().frame(height: 47)
        
        Text("비밀번호")
            .font(.PretendardRegular13)
            .foregroundStyle(Color.black)
            
        
        Spacer().frame(height: 1.98)
        
        Divider()
        
        Spacer().frame(height: 47)
        
        Button(action: {}, label: {
            Text("로그인하기")
                .font(.PretendardMedium16)
                .frame(maxWidth: .infinity, minHeight: 46)
                .background(Color.green01)
                .foregroundStyle(.white)
                .cornerRadius(20)
            
                
        })
        
    }
    
    
}


private var bottomSection: some View {
    VStack(alignment: .center) {
        
        Spacer().frame(height: 100)
        
        Text("이메일로 회원가입하기")
            .font(.PretendardRegular12)
            .foregroundStyle(.gray01)
            .underline()
            .frame(maxWidth:.infinity)
            
        
        Spacer().frame(height: 19)
        
        HStack {
            Spacer()
            Image(.kakao)
                .resizable()
                .frame(width: 306, height: 45)
                .aspectRatio(contentMode: .fit)
            Spacer()
        }
        
        Spacer().frame(height: 19)
        
        HStack {
            Spacer()
            Image(.apple)
                .resizable()
                .frame(width: 306, height: 45)
                .aspectRatio(contentMode: .fit)
            Spacer()
        }
        
    }

}




#Preview {
    LoginView()
}

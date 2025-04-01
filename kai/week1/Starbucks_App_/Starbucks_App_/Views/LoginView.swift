//
//  LoginView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 3/20/25.
//

import SwiftUI


struct LoginView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                
                Image("Starbucks")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 97, height: 95)
                
                Text("안녕하세요.\n스타벅스 입니다.")
                    .font(.Bold)
                    .fontWeight(.Bold)
                    .foregroundStyle(Color.회원서비스이용)
                
                Spacer().frame(height:104)
            }
        }
        .padding()
    }
}

#Preview {
    LoginView()
}

//
//  LoginView.swift
//  UMC-iOS-Starkbucks_App
//
//  Created by 김영택 on 3/20/25.
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
                
                /*Text("안녕하세요.\n스타벅스 입니다.")
                    .font(.Bold)
                    .fontWeight(.Bold)
                    .foregroundColor(.회원서비스이용)*/
            }
        }
        .padding() // 전체 padding
    }
}

#Preview {
    LoginView()
}

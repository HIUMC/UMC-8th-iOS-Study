//
//  ProfileView.swift
//  week2Practice
//
//  Created by tokkislove on 3/28/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack {
            Text("프로필 화면")
                .font(.largeTitle)
            //부모뷰 상태 자동 반영
            Text("사용자 이름: \(userViewModel.userName)")
                .font(.title)
            //값 변경 즉시 모든 뷰에 반영
            Button("이름 변경") {
                userViewModel.userName = "새로운 사용자"
            }
            .padding()
            .background(Color.blue)
            .foregroundStyle(.white)
        }
        
        
    }
}

#Preview {
    ProfileView()
        .environmentObject(UserViewModel())
}

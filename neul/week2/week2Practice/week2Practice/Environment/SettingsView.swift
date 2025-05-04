//
//  SettingsView.swift
//  week2Practice
//
//  Created by tokkislove on 3/28/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack {
            Text("설정 화면")
                .font(.largeTitle)
            TextField("사용자 이름 변경", text: $userViewModel.userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        
        
    }
}

#Preview {
    SettingsView()
        .environmentObject(UserViewModel())
}

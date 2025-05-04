//
//  SettingsView.swift
//  UMC-iOS-WorkBook
//
//  Created by 곽은채 on 3/25/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userViewModel: UserViewModel  // 동일한 전역 객체 사용

    var body: some View {
        VStack {
            Text("설정 화면")
                .font(.largeTitle)

            TextField("사용자 이름 변경", text: $userViewModel.username)  // TextField로 직접 변경 가능
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

#Preview {
    SettingsView().environmentObject(UserViewModel())
}

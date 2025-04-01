//
//  AppStorageView.swift
//  week2Practice
//
//  Created by tokkislove on 3/28/25.
//

import SwiftUI

struct AppStorageView: View {
    @AppStorage("userName") private var userName: String = "tokkislove"
    
    var body: some View {
        VStack {
            Text("내 이름은 \(userName)")
            Button("이름 변경") {
                userName = "UMC"
            }
        }
        
        
    }
}

#Preview {
    AppStorageView()
}

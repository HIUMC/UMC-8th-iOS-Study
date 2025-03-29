//
//  DarkModeView.swift
//  week2Practice
//
//  Created by tokkislove on 3/28/25.
//

import SwiftUI

struct DarkModeView: View {
    @AppStorage("userAge") private var userAge: Int = 25
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        VStack {
            Text("age: \(userAge)")
            Button("나이 증가") {
                userAge += 1
            }
            Toggle("Dark Mode", isOn: $isDarkMode)
                .frame(width: 150)
        }
        
        
    }
}

#Preview {
    DarkModeView()
}

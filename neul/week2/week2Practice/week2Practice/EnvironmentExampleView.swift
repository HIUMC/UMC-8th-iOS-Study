//
//  EnvironmentExampleView.swift
//  week2Practice
//
//  Created by tokkislove on 3/28/25.
//

import SwiftUI

struct EnvironmentExampleView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Text("현재 색상 모드: \(colorScheme == .dark ? "다크모드": "라이트모드")")
                .padding()
                .background(colorScheme == .dark ? Color.black : Color.white)
                .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
        }
        .padding()
        
        
    }
}

#Preview {
    EnvironmentExampleView()
}

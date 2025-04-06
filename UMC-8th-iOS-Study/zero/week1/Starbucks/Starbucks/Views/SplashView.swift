//
//  SplashView.swift
//  Starbucks
//
//  Created by 김영택 on 3/21/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.login)
                .frame(maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack {
                Image(.starbucslogo)
                    .resizable()
                    .frame(width: 168, height: 168)
            }
        }
    }
}
    #Preview {
        SplashView()
}


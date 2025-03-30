//
//  SplashView.swift
//  UMC-iOS-Starkbucks_App
//
//  Created by 김영택 on 3/20/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color("Starbucks_Green")
            
            ZStack {
                Image(.starbucks)
                    .resizable()
                    .frame(width: 168, height: 168)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}

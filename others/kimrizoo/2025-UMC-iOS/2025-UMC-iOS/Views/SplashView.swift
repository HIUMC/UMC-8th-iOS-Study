//
//  SplashView.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 3/20/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color(.mainGreen)
            
            VStack {
                Image("Starbucks")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 168, height: 168)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}

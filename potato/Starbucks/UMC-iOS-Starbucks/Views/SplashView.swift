//
//  SplashView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 3/30/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color("green01")
                .ignoresSafeArea()
            
            Image(.starbucksLogo)
                .resizable()
                .frame(maxWidth: 168, maxHeight: 168)
                .aspectRatio(contentMode: .fit)
        }
    }
}

#Preview {
    SplashView()
}

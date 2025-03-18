//
//  SplashView.swift
//  Starbucks
//
//  Created by nau on 3/18/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        //ZStack 기본 alignment가 center.
        ZStack() {
            Color(.green01).ignoresSafeArea()
            Image(.starbucksLogo)
                .resizable()
                .frame(width: 168, height: 168)
        }
    }
}

#Preview {
    SplashView()
}

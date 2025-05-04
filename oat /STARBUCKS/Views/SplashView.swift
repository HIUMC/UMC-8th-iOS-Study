//
//  SplashView.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/23/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.green01
                .ignoresSafeArea(.all)
            Image(.starbuckLogo)
        }
    }
}

#Preview {
    SplashView()
}

//
//  SplashView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/30/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color.loginButtonGreen.ignoresSafeArea(.all)
            Image("Starbucks")
            // sfsymbol 이미지가 아니면, Resizable 없이는 크기조정 불가
                .resizable()
                .frame(width: 168, height: 168)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        }
    }
}


#Preview {
    SplashView()
}

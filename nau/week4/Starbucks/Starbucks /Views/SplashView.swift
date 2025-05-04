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
                .frame(maxWidth: 168, maxHeight: 168)
        }
    }
}

struct SplashView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro"]
    
    static var previews: some View {
            ForEach(devices, id: \.self) { device in
                SplashView()
                    .previewDevice(PreviewDevice(rawValue: device))
                    .previewDisplayName(device)
            }
        }
}

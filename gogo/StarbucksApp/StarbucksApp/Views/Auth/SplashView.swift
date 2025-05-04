//
//  SplashView.swift
//  Starbucks_Week1_gogo
//
//  Created by 고석현 on 3/24/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack(alignment: .center) {
            
            Color(.green01)
                .ignoresSafeArea()
            Image(.background)
                .resizable()
                .frame(width:168, height:168 )
            
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


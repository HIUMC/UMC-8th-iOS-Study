//
//  LoginView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/22/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color.green01.ignoresSafeArea(.all)
            Image("logo")
                // sfsymbol 이미지가 아니면, Resizable 없이는 크기조정 불가
                .resizable()
                .frame(width: 168, height: 168)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        }
    }
}


struct SplashView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            SplashView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}

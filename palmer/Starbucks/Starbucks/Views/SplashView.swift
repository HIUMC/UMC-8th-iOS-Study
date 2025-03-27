//
//  SplashView.swift
//  1st_work
//
//  Created by 박정환 on 3/22/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color(.green01)
                .edgesIgnoringSafeArea(.all)
            Image(.logo)
                .resizable()
                .frame(width:168, height:168)
                //명암 넣어야됨
        }
    }
}


//preview
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

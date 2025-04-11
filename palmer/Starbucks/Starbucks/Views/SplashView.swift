//
//  SplashView.swift
//  1st_work
//
//  Created by 박정환 on 3/22/25.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var router: NavigationRouter

    var body: some View {
        ZStack(alignment: .center) {
            Color(.green01)
                .edgesIgnoringSafeArea(.all)
            Image(.logo)
                .resizable()
                .frame(width:168, height:168)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                router.push(.login)
            }
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

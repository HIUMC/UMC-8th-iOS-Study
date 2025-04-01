//
//  SplashView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 3/20/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color("starbucksGreen")
            
            VStack {
                Image("Starbucks")
                    .resizable()
                    .frame(width: 168, height: 168)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}

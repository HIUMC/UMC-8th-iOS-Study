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
/*Rectangle()
    .fill(Color.starbucksGreen)
    .frame(maxHeight: .infinity)
    .ignoreSafeArea()
 로 해도 전체 화면이 채워짐*/
            
            
            
            VStack {
                Image("starbucks")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 168, height: 168)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}



//
//  SplashView.swift
//  Starbucks
//
//  Created by 이가원 on 3/24/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.green1)
            Image(.starbucks)
        }
    }
}
#Preview {
    SplashView()
}

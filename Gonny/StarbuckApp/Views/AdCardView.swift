//
//  AdCardView.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/3/25.
//

import SwiftUI
//WhatsNew의 하위뷰
struct AdCardView: View {
    
    let ad: AdItem
    
    var body: some View {
        Image(ad.imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 180)
            .cornerRadius(16)
            .shadow(radius: 4)
    }
}

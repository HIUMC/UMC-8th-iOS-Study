//
//  MenuItemView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/7/25.
//

import SwiftUI

struct MenuItemView: View {
    var img: String
    var menuLabel: String
    
    var body: some View {
        Button(action: {
            print(menuLabel)
        }, label: {
            HStack(spacing: 4) {
                Image(img)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 32, height: 32)
                
                Text(menuLabel)
                    .font(.mainTextSemiBold16)
                    .foregroundStyle(Color("black01"))
            }
        })
        .frame(width: 157, height: 32, alignment: .leading)
    }
}

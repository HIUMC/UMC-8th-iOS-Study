//
//  WelcomeView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/7/25.
//

import SwiftUI

struct WelcomeView: View {
    var cardLabel: String
    var img: String
    var action: (() -> Void)?
    
    var body: some View {
        Button(action: {
            print(cardLabel)
            action?()
        }, label: {
            VStack(spacing: 4) {
                Image(img)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 38, height: 38)
                    .padding(5)
                
                Text(cardLabel)
                    .font(.mainTextSemiBold16)
                    .foregroundStyle(Color("black01"))
            }
        })
        .frame(width: 102, height: 70)
        .padding(.vertical, 19)
        .background() {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("white00"))
                .shadow(color: .black.opacity(0.1), radius: 2.5, x: 0, y: 0)
        }
    }
}

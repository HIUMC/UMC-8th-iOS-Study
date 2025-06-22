//
//  AddCardBViw.swift
//  Starbucks
//
//  Created by 이가원 on 4/5/25.
//

import SwiftUI

struct AddCard: View {
    let imageName: String
    let title: String
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(imageName)
                .resizable()
                .frame(width: 242, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            Text(title)
                .font(.custom("Pretendard-Bold", size: 18))

            Text(text)
                .font(.custom("Pretendard-Medium", size: 13))
                .foregroundColor(Color("gray3"))
        }
        .frame(width: 242)
    }
}

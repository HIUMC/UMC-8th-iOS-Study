//
//  AllCard.swift
//  STARBUCKS
//
//  Created by 신민정 on 4/4/25.
//

import Foundation
import SwiftUI

struct AllCard: View {
    var card: all
    var body: some View {
        VStack {
            Image(card.imageName)
            
            Text(card.title) 
                .font(.mainTextSemiBold13)
                .foregroundStyle(Color.black02)
        }
    }
}

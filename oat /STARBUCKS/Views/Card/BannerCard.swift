//
//  Bannercard.swift
//  STARBUCKS
//
//  Created by 신민정 on 4/4/25.
//

import Foundation
import SwiftUI

struct BannerCard: View {
    var card: banner
    var body: some View {
        VStack {
            Image(card.imageName)
        }
    }
}

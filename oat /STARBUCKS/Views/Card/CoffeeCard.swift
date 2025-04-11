//
//  CoffeeCard.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/28/25.
//

import SwiftUI

struct CoffeeCard: View {
    var card: WhatsNew
    var body: some View {
        VStack {
            Image(card.imageName)
        }
    }
}


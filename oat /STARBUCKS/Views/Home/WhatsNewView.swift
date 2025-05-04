//
//  WhatsNewView.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/28/25.
//

import SwiftUI

struct WhatsNewView: View {
    @StateObject var NewModel = WhatsNewViewModel()
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing:16) {
                ForEach(NewModel.WhatNewMenu) {
                    card in CoffeeCard(card: card)
                }
            }
           
        }
        .padding()
    }
}

#Preview {
    WhatsNewView()
}


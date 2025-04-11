//
//  ShopView.swift
//  STARBUCKS
//
//  Created by 신민정 on 4/4/25.
//

import SwiftUI

struct Banner2View: View {
    @StateObject var NewModel = BannerViewModel()
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack{
                ForEach(NewModel.Bannername) {
                    card in BannerCard(card: card)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    Banner2View()
}

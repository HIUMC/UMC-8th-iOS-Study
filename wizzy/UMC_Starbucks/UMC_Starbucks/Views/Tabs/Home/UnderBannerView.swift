//
//  UnderBannerView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/3/25.
//

import SwiftUI

struct UnderBannerView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Group {
                Image("coldbreuBanner")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Image("beverageBanner")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Image("sizeupBanner")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .shadow(color: .black.opacity(0.06), radius: 2, x: 0, y: 6)
            .shadow(color: .black.opacity(0.1), radius: 2, x: 1, y: 1)
        } //v
        .padding(10)
    }
}

#Preview {
    UnderBannerView()
}

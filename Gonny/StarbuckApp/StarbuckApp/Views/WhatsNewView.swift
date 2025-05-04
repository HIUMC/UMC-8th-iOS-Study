//
//  WhatsNew.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/3/25.
//
import SwiftUI
struct WhatsNewView: View {
    @StateObject private var viewModel = WhatsNewViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What's New")
                .font(.mainTextBold24)
                .foregroundStyle(Color("black03"))
                .padding(.horizontal, 40)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.adItems) { ad in
                      AdCardView(ad: ad)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}


#Preview {
    WhatsNewView()
}



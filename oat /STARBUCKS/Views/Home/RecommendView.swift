//
//  recommendView.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/28/25.
//

import SwiftUI

struct RecommendView: View {
    @StateObject var recViewModel = RecommendViewModel()
    var body: some View {
        VStack {
            VStack(alignment: .leading){  (Text("\(UserManager.shared.nickname)")
                .foregroundStyle(Color.brown01)
                                           + Text("을 위한 추천 메뉴" ) )
            .font(.mainTextBold24)
            .foregroundStyle(Color.black03)
                    ScrollView(.horizontal) {
                        LazyHStack(spacing:16) {
                            ForEach(recViewModel.recommendMenu) { menu in
                                NavigationLink {
                                    DetailView(coffee: menu)
                                } label: {
                                    CircleImageCard(imageName: menu.cardImageName)
                                }
                            }
                        
                    }
                }
                .frame(height:170)
                
            }
        }
        .padding()
    }
}


#Preview {
    RecommendView()
}

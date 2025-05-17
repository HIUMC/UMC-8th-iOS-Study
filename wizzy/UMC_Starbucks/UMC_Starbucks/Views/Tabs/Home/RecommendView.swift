//
//  RecommendView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/3/25.
//

import SwiftUI

struct RecommendView: View {
    @StateObject var recoviewModel = CoffeeViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Group {
                    Text("\(recoviewModel.nickname)")
                        .foregroundStyle(Color.brown02)
                        .padding(.leading, 19)
                    Text("님을 위한 추천 메뉴")
                        .foregroundStyle(Color.black03)
                }
                .font(.PretendardBold24)
            }

            ScrollView(.horizontal) {
                LazyHStack(spacing: 15) {
                    ForEach(recoviewModel.recommendCoffeeList) { menu in
                        NavigationLink {
                            CoffeeView(coffee: menu)
                        } label: {
                            CircleImageCard(
                                imageName: menu.image,
                                coffeetitle: menu.title
                            )
                        }
                        
                            
                            
                        }
                    }
                
                }
            .padding(.horizontal)
            }
        .frame(height: 230)
        }
    
    }


#Preview {
    RecommendView()
}

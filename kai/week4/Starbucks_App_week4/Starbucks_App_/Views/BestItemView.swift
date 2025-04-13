//
//  BestItemView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 4/10/25.
//

/*

import SwiftUI

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}


struct BestItemView: View {
    @State private var currentPage = 0
    @Bindable private var bestItemViewModel = BestItemViewModel()

    let columns = Array(repeating: GridItem(.flexible()), count: 2)//flexible-> 크기 계산 오래걸림 : min/max 정해주기(사이즈 고정)
    let itemsPerPage = 4

    var pagedItems: [[CoffeeCardModel]] {
        bestItemViewModel.BestItems.chunked(into: itemsPerPage)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Best Items")
                .font(.PretendardSemiBold24)
                .foregroundStyle(Color.black)

            TabView(selection: $currentPage) {
                ForEach(0..<pagedItems.count, id: \.self) { index in
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(pagedItems[index]) { bestitem in
                            VStack {
                                Image(bestitem.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 157, height: 156)
                                    .clipped()
                                
                                Text(bestitem.title)
                                    .font(.pretendard)
                            }//VStack자체를 뷰로 만들기
                        }
                    }
                    .padding()
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .frame(height: 400) // 원하는 높이로 조정
        }
        .padding(.horizontal)
    }
}


#Preview {
    BestItemView()
}

*/

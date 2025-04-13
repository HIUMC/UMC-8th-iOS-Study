//
//  BestItemsView.swift
//  Starbucks
//
//  Created by 김영택 on 4/10/25.
//

import SwiftUI

struct BestItemsView: View {
    
    @StateObject var viewModel = BestItemsViewModel()
    @State private var currentPage = 0
    
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    let itemsPerPage = 4  // 2행 × 2열
    
    // 페이지 단위로 나누기
    var pagedItems: [[BestItemsModel]] {
        viewModel.bestitems.chunked(into: itemsPerPage)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Best Items")
                .font(.PretendardSemibold22)
                .padding(.leading, 20)
            
            Spacer().frame(height: 16)
            
            TabView(selection: $currentPage) {
                ForEach(0..<pagedItems.count, id: \.self) { pageIndex in
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(pagedItems[pageIndex], id: \.self) { menu in
                            VStack {
                                Image(menu.bestItemsImageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 157, height: 156)
                                    .clipped()
                                
                                Text(menu.bestItemsName)
                                    .font(.PretendardSemibold14)
                            }
                        }
                    }
                    .padding()
                    .tag(pageIndex) //현재 페이지 식별을 위한 태그
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // 기본 인디케이터 숨김
            .frame(height: 400)
            
            //커스텀 페이지 인디케이터 추가
            HStack(spacing: 8) {
                ForEach(0..<pagedItems.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentPage ? Color.black : Color.gray.opacity(0.4))
                        .frame(width: 8, height: 8)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 4)
        }
    }
}


extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: self.count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, self.count)])
        }
    }
}

#Preview {
    BestItemsView()
}

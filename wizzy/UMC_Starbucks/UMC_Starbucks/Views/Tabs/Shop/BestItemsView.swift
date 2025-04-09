//
//  BestItemsView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/6/25.
//

import SwiftUI

struct BestItemsView: View {
    @StateObject private var bestItem = BestItemsViewModel()
    //@ObservedObject var bestItem: BestItemsViewModel
    
    var body: some View {
        
        // var pages = [] // 사진 담기
        VStack (alignment: .leading, spacing: 0){
            Text("Best Items")
                .font(.PretendardSemiBold22)
                //.padding(.bottom, 16)
            TabView(selection: $bestItem.currentPage) {
                ForEach(Array(bestItem.pages.enumerated()), id: \.offset) { index, itemList in
                    bestItemGrid(items: itemList)
                        .tag(index)
                }
            }
            //.frame(height: 900)
            //.border(Color.red)
            .frame(height: 500, alignment: .top)
            //.tabViewStyle(PageTabViewStyle())
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            //PageTabViewStyle ; 수평스와이프 | indexDisplayMode: .never ; 기본 페이지인디케이터 X


            
            
            PageIndicator(all: bestItem.pages.count, currentIndex: bestItem.currentPage)
                    .frame(maxWidth: .infinity, alignment: .center)
            
            
            
            
        }
        .padding(.horizontal, 10)// v
    }

    @ViewBuilder
    func bestItemGrid(items: [BestItemModel]) -> some View {
        let columns = [
            GridItem(.flexible(), spacing: 65), //.flexble인데도 왜..흠
            GridItem(.flexible(), spacing: 65)
        ]

        LazyVGrid(columns: columns, spacing: 65) {
            ForEach(items) { item in
                VStack (alignment: .leading, spacing: 2) {
                    Image(item.imageName)
                     .resizable()
                     .scaledToFit()
                     .frame(width: 157, height: 156)
                     .background(Color.white)
                     .cornerRadius(5)
                     
                VStack(alignment: .leading, spacing: 2) { 
                        Text(item.itemTitle)
                        Text(item.size)
                    }
                    .font(.PretendardSemiBold14)
                    .foregroundStyle(Color.black02)
                    .kerning(-0.42)
                     
                
                } //v
                    
            }
        }
        .padding(16)
    }
 
    

    }
    


struct PageIndicator: View {
    let all: Int // 전체 페이지 수
    let currentIndex: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<all, id: \.self) { index in // 인디케이터 점 (전체 페이지만큼 만들기)
                Circle()
                    .strokeBorder(Color.gray, lineWidth: 1)
                    .background(
                        Circle()
                            .fill(index == currentIndex ? Color.black : Color.clear)
                    ) // 현 페이지면 검정 , 아니면 투명
                    .frame(width: 10, height: 10)
            }
        }
        .padding(.top, 8)
    }
}

struct BestItemsView_Previews: PreviewProvider {
    static var previews: some View {
        BestItemsView()
    }
}

/*
 struct BestItemsView_Previews: PreviewProvider {
 static var previews: some View {
 BestItemsView()
 }
 }
 */

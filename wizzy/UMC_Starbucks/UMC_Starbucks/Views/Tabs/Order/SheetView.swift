//
//  SheetView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/3/25.
//

import SwiftUI

struct SheetView: View {
    @State private var showMap = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text("매장 설정")
                    .font(.PretendardMedium16)
                    .kerning(-0.8)
                Spacer()
                Button(action: { showMap.toggle() }) {
                    Image(systemName: showMap ? "list.bullet" : "map")
                        .resizable()
                        .frame(width: 18, height: 17)
                }
            }
            .padding(.vertical, 24)
            //.padding(.horizontal, 36)

            // SearchBar 항상 상단 고정
            SearchBar()

            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 0) {
                        if showMap {
                            HStack {
                                MapView()
                                Spacer(minLength: 0)
                            }
                            .frame(minHeight: geometry.size.height)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        } else {
                            VStack {
                                storeBar()
                                JSONParsingView()
                                    .padding(.horizontal, 23)
                                //HybridMapView()
                            }
                            .frame(minHeight: geometry.size.height)
                            .frame(maxWidth: .infinity)
                        }

                        Divider()
                            .foregroundStyle(Color.gray07)
                            .frame(width: 440, height: 1)
                            .padding(.top, 15)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .padding(.horizontal, 30)
        
    }//body
}//struct

// MARK: - View

struct SearchBar: View {
    var body: some View {
        VStack{
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(Color.gray08)
                    .frame(width: 375, height: 27)
                
                Text("검색")
                    .foregroundStyle(Color.searchGray)
                    .padding(.leading, 10)
                
            }//z
            .padding(.bottom, 22)
        
            
        }//v
    }
}

// MARK: - Subviews

struct storeBar: View {
    enum StoreCategory: String, CaseIterable {
        case nearby = "가까운 매장"
        case usually = "자주 가는 매장"
    }
    @State private var selectedStore: StoreCategory = .nearby
    
    var body: some View {
        HStack() {
            ForEach(StoreCategory.allCases.indices, id: \.self) { index in
                let store = StoreCategory.allCases[index]
                Button(action: {
                    selectedStore = store
                }) {
                    HStack(spacing: 4) {
                        Text(store.rawValue)
                            .font(.PretendardSemiBold13)
                            .foregroundStyle(selectedStore == store ? .black : .gray03)
                            .kerning(-0.65)
                    }
                }
                if index < StoreCategory.allCases.count - 1 {
                    Text("|")
                        .foregroundStyle(.gray03)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 23)
        
    }
    
}
// MARK: - Subviews





#Preview {
    SheetView()
}

//
//  OrderSheetView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 5/4/25.
//

import SwiftUI

enum SegmentOption3: String, CaseIterable, Identifiable {
    case first = "가까운 매장"
    case second = "자주 가는 매장"
    
    var id: String { self.rawValue }
}

struct OrderSheetView: View {
    @State private var segment: SegmentOption3 = .first
    @Environment(MapListViewModel.self) var viewModel
    
    @State var isMap: Bool = false
    @State var text: String = ""
    
    var body: some View {
        VStack {
            Spacer().frame(height: 30)
            
            titleBar
                .frame(
                    minWidth: UIScreen.main.bounds.width - 32.5,
                    maxWidth: UIScreen.main.bounds.width - 28
                )

            
            searchBar
                .frame(
                    minWidth: UIScreen.main.bounds.width - 32.5,
                    maxWidth: UIScreen.main.bounds.width - 28)
            
            bottomSegment
            
        }
        .presentationDragIndicator(.visible)
        .task {
            if let location = LocationManager.shared.currentLocation {
                viewModel.setUserLocation(location)
            }
        }
    }
    
    private var titleBar: some View {
        HStack {
            Button(action: {}, label: {
                Image(.marker)
                    .renderingMode(.template)
                    .foregroundStyle(.white)
            })
           
            Spacer()
            
            Text("매장 설정")
                .font(.PretendardMedium16)
                .foregroundStyle(.black)
            
            Spacer()
            
            Button(action: {
                isMap.toggle()
            }, label: {
                Image(.marker)
            })
        }
    }
    
    private var searchBar: some View {
        VStack {
            TextField("검색", text: $text)
                .font(.PretendardRegular12)
                .padding(EdgeInsets(top: 4, leading: 7, bottom: 4, trailing: 7))
        }
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
    
    private var bottomSegment: some View {
        VStack(alignment: .leading, spacing: 0) {
            content
                .frame(
                    maxWidth: UIScreen.main.bounds.width - 2.2)

            Divider()
            
            selectedTab
        }
    }
    
    private var content: some View {
        HStack {
            ForEach(SegmentOption3.allCases) { tab in
                Button(action: {
                    segment = tab
                }) {
                    VStack {
                        Text(tab.rawValue)
                            .foregroundColor(segment == tab ? .black : .gray)
                            .font(segment == tab ? .PretendardRegular13 : .PretendardRegular13)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 8)
        .background(Color.white)
    }

    private var selectedTab : some View {
        // 실제 탭에 따른 콘텐츠 영역
        VStack{
            switch segment {
            case .first:
                if isMap {
                    MapView()
                } else {
                    MapListView()
                }
            case .second:
                if isMap {
                    MapView()
                } else {
                    Text("Second")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct MapListView: View {
    @Environment(MapListViewModel.self) var viewModel
    
    var body: some View {
        VStack {
            
            content
        }
        .frame(
            minWidth: UIScreen.main.bounds.width - 32.5,
            maxWidth: UIScreen.main.bounds.width - 28)
        
        .padding(.top, 20)
    }
    
    private var content: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 15) {
                if viewModel.filteredStores.isEmpty {
                    Text("No stores found")
                } else {
                    ForEach(viewModel.filteredStores) { store in
                        MapListCard(store)
                    }
                }
            }
        }
    }
    
    private func MapListCard(_ store: MapListModel) -> some View {
        
        HStack {
            Image(store.image)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 7))
                .frame(width: 83, height: 83)
            
            Spacer().frame(width: 13)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(store.name)
                    .font(.PretendardRegular13)
                    .foregroundStyle(.black)
                
                Text(store.address)
                    .lineLimit(1)
                    .font(.PretendardRegular12)
                    .foregroundStyle(.gray)
                
                Spacer().frame(height: 12)
                
                HStack {
                    HStack {
                        let storeCategory = StoreCategory(from: store.category)
                        /*
                        HStack {
                        *ForEach(storeCategory.icons, id: \.self) { icon in
                                Image(icon)
                            }
                        } */
                        
                        Spacer()
                        
                        if let distance = store.distance {
                            if distance < 1000 {
                                Text(String(format: "%.0f m", distance))
                                    .font(.PretendardRegular12)
                                    .foregroundStyle(.black)
                            } else {
                                Text(String(format: "%.2f km", distance/1000))
                                    .font(.PretendardRegular12)
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                }
            }.frame(minHeight: 83)
        }
    }
}

#Preview {
    OrderSheetView()
}

//
//  OrderSheetView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/1/25.
//

import SwiftUI

enum StoreSegment: String, CaseIterable {
    case nearby = "가까운 매장"
    case favorite = "자주 가는 매장"
}

struct OrderSheetView: View {
    @State private var isMap = false
    @State private var showSheet: Bool = false
    @State private var selectedStoreTab: StoreSegment = .nearby

    @ObservedObject private var viewModel = MapListViewModel()

    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Text("매장 설정")
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                Button(action: { isMap.toggle() }, label: { Image(.map) })
                    .padding(.trailing, 40)
            }
            
            ZStack(alignment: .leading) {
                Image("search")
                Text("검색")
                    .font(.mainTextSemiBold16)
                    .foregroundStyle(.grey00)
                    .padding(.leading, 7)
            }
            
            HStack {
                ForEach(StoreSegment.allCases, id: \.self) { tab in
                    Button(action: {
                        selectedStoreTab = tab
                    }) {
                        Text(tab.rawValue)
                            .font(.system(size: 16, weight: .semibold))
                            .padding()
                            .foregroundColor(selectedStoreTab == tab ? .black03: .grey03)
                        
                    }
                }
            }
            VStack{
                switch selectedStoreTab {
                case .nearby:
                    if isMap {
                        MapView()
                    } else {
                        MapListView(viewModel: viewModel)
                    }
                case .favorite:
                    Text("아직없음")
                }
            }
        }
        
        .padding(.horizontal)
        .task {
            if let location = LocationManager.shared.currentLocation {
                viewModel.setUserLocation(location)
            }
            viewModel.loadGeoJSON { result in
                switch result {
                case .success(let stores):
                    // 성공적으로 데이터를 불러왔을 때 추가 로직
                    print("Stores loaded: \(stores)")
                case .failure(let error):
                    // 오류 처리
                    print("Error loading stores: \(error)")
                }
            }
        }.background(Color.white)
}
    
    }


struct MapListView: View {

    @ObservedObject var viewModel: MapListViewModel

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 15) {
                if viewModel.filteredStores.isEmpty {
                    Text("No Stores Found")
                } else {
                    ForEach(viewModel.filteredStores) { store in
                        MapListCard(store)
                    }
                }
            }
            .padding()
        }
    }

    func MapListCard(_ store: MapListModel) -> some View {
        HStack {
            Image(store.image)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 7))
                .frame(width: 83, height: 83)

            Spacer().frame(width: 13)

            VStack(alignment: .leading, spacing: 3) {
                Text(store.name)
                    .font(.mainTextSemiBold13)
                    .foregroundStyle(.black03)

                Text(store.address)
                    .lineLimit(1)
                    .font(.mainTextMedium10)
                    .foregroundStyle(.grey02)

                Spacer().frame(height: 12)

                HStack {
                    HStack {
                        let storeCategory = StoreCategory(from: store.category)

                        HStack {
                            ForEach(storeCategory.icons, id: \.self) { icon in
                                Image(icon)
                            }
                        }

                        Spacer()

                        if let distance = store.distance {
                            if distance < 1000 {
                                Text(String(format: "%.0f m", distance))
                                    .font(.mainTextRegular12)
                                    .foregroundStyle(.black01)
                            } else {
                                Text(String(format: "%.2f km", distance / 1000))
                                    .font(.mainTextRegular12)
                                    .foregroundStyle(.black01)
                            }
                        }
                    }
                }
            }
            .frame(minHeight: 83)
        }
    }
}

#Preview {
    OrderSheetView()
}


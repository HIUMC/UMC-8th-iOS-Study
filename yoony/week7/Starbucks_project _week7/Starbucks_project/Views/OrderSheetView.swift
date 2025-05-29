//
//  OrderSheetView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/1/25.
//

import SwiftUI
import Kingfisher

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
                        MapView(findLocationViewModel: FindLocationViewModel())
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
            // ✅ 위치 추적 강제 시작
            LocationManager.shared.startUpdatingLocation()

            // 현재 위치 확인
            if let location = LocationManager.shared.currentLocation {
                print("✅ 수동 위치 확인 성공: \(location.coordinate)")
                viewModel.setUserLocation(location)
            } else {
                print("⚠️ currentLocation이 여전히 nil입니다")
            }

            // 매장 데이터 로딩
            viewModel.loadGeoJSON { result in
                switch result {
                case .success(let stores):
                    print("✅ 매장 개수: \(stores.count)")
                case .failure(let error):
                    print("❌ 매장 불러오기 실패: \(error)")
                }
            }
        }
.background(Color.white)
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
            // ✅ 조건: photoReference가 있으면 KFImage 사용
            if let photoRef = store.photoReference,
               let url = googlePhotoURL(photoReference: photoRef) {
                KFImage(url)
                    .onFailure { error in
                        print("이미지 로드 실패: \(error.localizedDescription)")
                    }
                    .placeholder {
                        // 이미지 로딩 중 보여줄 뷰
                        Color.gray
                            .frame(width: 83, height: 83)
                            .cornerRadius(7)
                            .overlay(Text("로딩중").font(.caption).foregroundColor(.white))
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 83, height: 83)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    .clipped()
            }

                
            else {
                // ✅ fallback: 기존 ImageResource 방식
                Image(store.image)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    .frame(width: 83, height: 83)
            }

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
            .frame(minHeight: 83)
        }
    }
    func googlePhotoURL(photoReference: String) -> URL? {
        let apiKey = Bundle.main.googleAPIKey
        let urlString = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(photoReference)&key=\(apiKey)"
        return URL(string: urlString)
    }
}

#Preview {
    OrderSheetView()
}


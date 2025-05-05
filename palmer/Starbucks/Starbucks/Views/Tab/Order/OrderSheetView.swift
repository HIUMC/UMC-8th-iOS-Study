//
//  OrderSheetView.swift
//  Starbucks
//
//  Created by 박정환 on 5/2/25.
//

import SwiftUI
import CoreLocation

struct OrderSheetView: View {
    @State var isMap: Bool = false
    @State private var searchText: String = ""
    @State private var selectedTab = 0
    
    @Bindable var viewModel: JSONParsingViewModel
    @Bindable private var locationManager: LocationManㅜ12ager = .shared
    
    @Bindable private var mapViewModel: MapViewModel = .init()
    
    var body: some View {
        VStack {
            topNav
            searchBar
            storeNav
            
            Divider()
            
            if selectedTab == 0 {
                if isMap {
                    MapView(showsUserLocationButton: false)
                        .padding(.horizontal, -32)
                        .ignoresSafeArea()
                } else {
                    stores
                }
            } else {
                Text("2")
                Spacer()
            }
        }
        .onAppear {
            locationManager.requestAuthorization()
            locationManager.startUpdatingLocation()
            
            viewModel.loadStoreList { result in
                switch result {
                case .success(_):
                    print("가까운 매장 반환")
                case .failure(let error):
                    print("store list error: \(error)")
                }
            }
        }
        .onChange(of: locationManager.currentLocation) {
            if let location = locationManager.currentLocation {
                // 정확도 50미터 이하인 위치만 사용
                let desiredAccuracy: CLLocationAccuracy = 50
                if location.horizontalAccuracy <= desiredAccuracy {
                    viewModel.userLocation = location
                    print(location.coordinate.latitude, location.coordinate.longitude )
                }
            }
        }
        .onDisappear {
            locationManager.stopUpdatingLocation()
        }
        .background(Color("white00"))
        .padding(.horizontal, 32)
        .presentationDragIndicator(.visible)
    }
    
    private var topNav: some View {
        HStack {
            Spacer()
            Text("매장 설정")
                .foregroundStyle(Color("black03"))
                .font(.mainTextMedium16)
            Spacer()
            Button(action: {
                isMap.toggle()
            }, label: {
                Image(systemName: isMap ? "list.bullet" : "map")
                    .foregroundStyle(Color("gray04"))
            })
        }
        .padding(.top, 40)
        .padding(.bottom, 24)
    }
    
    private var searchBar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 28)
                .foregroundStyle(Color("gray08"))
            
            TextField("검색", text: $searchText)
            /* onCommit: {
             if let location = locationManager.currentLocation {
                    mapViewModel.search(query: searchText, to: location)
             }
         })
             */
                .font(.mainTextSemiBold13)
                .foregroundStyle(Color("gray01"))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding(.leading, 8)
        }
    }
    
    private var storeNav: some View {
        HStack(spacing: 10) {
            ForEach(StoreType.allCases, id: \.self) { type in
                Text(type.title)
                    .foregroundStyle(selectedTab == type.id ? Color("black03") : Color("gray03"))
                    .font(.mainTextSemiBold13)
                    .onTapGesture {
                        selectedTab = type.id
                    }
                
                if type.id == 0 {
                    Text("|")
                        .foregroundStyle(Color("gray03"))
                        .font(.mainTextSemiBold13)
                }
            }
            
            Spacer()
        }
        .padding(.top, 20)
        .padding(.bottom, 16)
    }
    
    private var stores: some View {
        ScrollView {
            if !viewModel.sortedStores.isEmpty {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(Array(viewModel.sortedStores.enumerated()), id: \.element.id) { index, store in
                        StoreCardView(store: store, distance: viewModel.distances[store.id])
                            .padding(.top, index == 0 ? 28 : 0)
                            .padding(.bottom, index == viewModel.sortedStores.count - 1 ? 24 : 0)
                    }
                }
            } else {
                Text("가까운 매장이 존재하지 않습니다.")
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    var viewModel: JSONParsingViewModel = .init()
    OrderSheetView(viewModel: viewModel)
}

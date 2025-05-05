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
    @Bindable private var locationManager: LocationManager = .shared
        
    var body: some View {
        VStack {
            Capsule(style: .circular)
                .fill(.gray04)
                .frame(width: 70, height: 4)
                .padding(.top, 10)
            
            topNav
            searchBar
            storeNav
            
            Divider()
            
            if selectedTab == 0 {
                if isMap {
                    mapView
                } else {
                    storeListView
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
    
    // 상단 네비게이션바
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
                .font(.mainTextSemiBold13)
                .foregroundStyle(Color("gray01"))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding(.leading, 8)
        }
    }
    
    private var storeNav: some View {
        HStack(spacing: 0) {
                ForEach(OrderSheetSegment.allCases.indices, id: \.self) { index in
                    let segment = OrderSheetSegment.allCases[index]

                    HStack(spacing: 0) {
                        Text(segment.title)
                            .foregroundStyle(viewModel.selectedSegment == segment ? .black03 : .gray03)
                            .font(.pretendardSemiBold(13))
                            .onTapGesture {
                                withAnimation {
                                    viewModel.selectedSegment = segment
                                }
                            }

                        if index < OrderSheetSegment.allCases.count - 1 {
                            Image("verticalLine")
                                .padding(.horizontal, 10)
                        }
                    }
                }
            }
    }
    
    private var storeListView: some View {
        ScrollView {
            if !$viewModel.sortedStores.isEmpty {
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
    
    // 맵뷰
    private var mapView: some View {
        ZStack(alignment: .top) {
            Map(position: $viewModel.cameraPosition) {
                if let stores = viewModel.pinStores {
                    ForEach(stores, id: \.properties.Seq, content: { store in
                        let location = CLLocationCoordinate2D(
                            latitude: store.properties.Ycoordinate,
                            longitude: store.properties.Xcoordinate
                        )
                        
                        Annotation(store.properties.Sotre_nm, coordinate: location, content: {
                            ZStack {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle( .green02)
                                
                                Image("Starbucks")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            }
                        })
                    })
                    
                    UserAnnotation(anchor: .center)
                }
            }
            .onMapCameraChange { context in
                viewModel.visibleRegion = context.region
                hasDraggedMap = true
            }
            
            if hasDraggedMap {
                Button(action : {
                    print("버튼 클릭")
                    viewModel.calculateDistanceFromRegionCenter()
                    hasDraggedMap = false
                }) {
                    Text("이 지역 검색")
                        .font(.pretendardMedium(13))
                        .foregroundStyle(.gray06)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .frame(width: 88, height: 36)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                        )
                }
                .offset(y: 25)
            }
        }
    }
    
}

#Preview {
    var viewModel: JSONParsingViewModel = .init()
    OrderSheetView(viewModel: viewModel)
}

//
//  OrderSheetView.swift
//  Starbucks
//
//  Created by 박정환 on 5/2/25.
//

import SwiftUI
import CoreLocation
import _MapKit_SwiftUI

struct OrderSheetView: View {
    @State var isMap: Bool = false
    @State private var searchText: String = ""
    @State private var selectedTab = 0
    @State private var hasDraggedMap: Bool = false
    
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
            viewModel.loadStores()
        }
        .task {
            await viewModel.calculateDistanceFromCurrentLocation()
        }
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
    
    // 매장 리스트 뷰
    private var storeListView: some View {
        ScrollView(.vertical, content: {
            LazyVStack(spacing: 16, content: {
                if let stores = viewModel.stores {
                    ForEach(stores.indices, id: \.self) { index in
                        StoreCardView(model: stores[index])
                            .padding(.top, index == 0 ? 28 : 0)
                    }
                }
            })
        })
        .padding(.horizontal, 32.5)
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

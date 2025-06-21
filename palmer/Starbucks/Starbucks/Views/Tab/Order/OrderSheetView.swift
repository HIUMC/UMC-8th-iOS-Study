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
    @Bindable var locationManager: LocationManager
        
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
                    MapView(viewModel: viewModel, hasDraggedMap: $hasDraggedMap)
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
                .fill(Color("gray08"))
                .frame(height: 28)
            
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
                            .frame(maxWidth: .infinity, alignment: .leading)
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
    
}

#Preview {
    OrderSheetView(viewModel: JSONParsingViewModel(), locationManager: LocationManager())
}

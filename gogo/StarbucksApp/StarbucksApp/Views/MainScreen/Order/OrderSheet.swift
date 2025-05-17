//
//  OrderSheet.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/29/25.
//

import SwiftUI

struct OrderSheet: View {
    
    var viewModel: JSONParsingViewModel

    @State private var isMapMode: Bool = false //맵 뜨는것.
    @State private var keyword: String = "" // 검색 창 입력 값
    @State private var closeTapped: Bool = true
    @Bindable var locationManager = LocationManager.shared
    var mapViewModel = MapViewModel()

    var body: some View {
        VStack {
            Capsule(style: .circular)
                .fill(Color.gray04)
                .frame(width: 70, height: 4)
                .padding(.top, 11)

            navigationBar
            searchBar   

            Spacer()

            if !isMapMode && closeTapped {
                if let storeData = viewModel.storeData {
                    StoreListView(stores: storeData.features, viewModel: mapViewModel)
                }
            } else if isMapMode {
                StoreMapView(viewModel:mapViewModel,locationManager: locationManager)
            }

            Spacer()
        }
        .onAppear {
            if let storeData = viewModel.storeData {
                mapViewModel.stores = storeData.features
            }
        }
//        .onAppear {
//            viewModel.loadStoreData { result in
//                switch result {
//                case .success(let data):
//                    mapViewModel.stores = data.features
//                case .failure(let error):
//                    print("로딩 실패: \(error.localizedDescription)")
//                }
//            }
//        }
    }
}



extension OrderSheet {
    
    
    //MARK: -네비게이션 바
    private var navigationBar: some View {
        ZStack {
            Text("매장 설정")
                .font(.PretendardMedium16)
            
            HStack {
                Spacer()
                Button(action: {
                    isMapMode.toggle()
                }) {
                    Image(isMapMode ? "maplist" : "map")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
            .padding(.horizontal,32.5)
        }
        .frame(height: 50)
        .background(Color.white)
    }
    
    
    //MARK: -검색 바 (기능 구현 아직 x)
        private var searchBar: some View {
            VStack(spacing:17) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray6))
                    
                    HStack {
                        
                        TextField("검색",text:$keyword)
                            .foregroundColor(.gray)
                            .font(.PretendardSemiBold13)
                            .padding(.leading,5)
                        Spacer()
                    }
                    
                }
                
                .frame(height: 36)
                .padding(.top, 12)
                
                
                HStack(spacing: 5) {
                    Button(action: {
                        closeTapped = true
                    }) {
                        Text("포장 주문")
                            .font(closeTapped ? .PretendardSemiBold13 : .PretendardRegular13)
                            .foregroundStyle(closeTapped ? .black03 : .gray03)
                    }
                    
                    Text("|")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.gray02)
                    
                    Button(action: {
                        closeTapped = false
                    }) {
                        Text("자주 가는 매장")
                            .font(!closeTapped ? .PretendardSemiBold13 : .PretendardRegular13)
                            .foregroundStyle(!closeTapped ? .black03 : .gray03)
                    }
                    
                    Spacer()
                }
                
            }
            .padding(.horizontal, 32.5)
        }
    }


#Preview {
    OrderSheet(viewModel: .init())
}

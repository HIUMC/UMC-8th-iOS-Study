//
//  SheetView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/29/25.
//

import SwiftUI

struct SheetView: View {
    var viewModel: JSONParsingViewModel
    @State private var isMap: Bool = false
    @State private var closeTapped: Bool = true
    @StateObject private var mapState = StoreMapStateViewModel()
    @State var keyword: String = "" // 나중에 binding 등으로 바꿔줘야 할지도
    
    @Bindable var locationManager = LocationManager.shared
    @EnvironmentObject var mapViewModel: MapViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Capsule(style: .circular)
                .fill(Color.gray04)
                .frame(width: 70, height: 4)
                .padding(.top, 11)
            navigationBar
            
            searchBar
            
            
            if !isMap && closeTapped {
                if let storeData = viewModel.storeData {
                    StoreListView(stores: storeData.features)
                }
            } else if isMap {
                StoreMapContainerView(locationManager: locationManager, mapState: mapState)
            } else {
                EmptyView()
            }
        }
        .onAppear {
            if let storeData = viewModel.storeData {
                mapViewModel.stores = storeData.features
            }
        }
        
    }
    
    private var navigationBar: some View {
        HStack {
            Spacer()
            Text("매장 설정")
                .foregroundStyle(.black03)
                .font(.MainTextMedium16)
                .padding(.leading, 20)
            Spacer()
            Button(action: {
                isMap.toggle()
            }, label: {
                Image(isMap ? "backToList" : "map")
                    .resizable()
                    .frame(width: 18, height: 18)
            })
        }
        .padding(.vertical, 22)
        .padding(.horizontal, 32.5)
    }
    
    private var searchBar: some View {
        VStack(spacing: 17) {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.gray08)
                .frame(maxWidth: .infinity, maxHeight: 30)
                .overlay {
                    TextField("검색", text: $keyword)
                        .font(.pretend(type: .semibold, size: 12))
                        .padding()
                }
                .padding(.bottom, 5)
            HStack(spacing: 5) {
                Button(action: {
                    closeTapped = true
                }, label: {
                    Text("가까운 매장")
                        .font(closeTapped ? .MainTextSemiBold13 : .MainTextRegular13)
                        .foregroundStyle(closeTapped ? .black03 : .gray03)
                })
                Text("|")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(.gray02)
                Button(action: {
                    closeTapped = false
                }, label: {
                    Text("자주 가는 매장")
                        .font(!closeTapped ? .MainTextSemiBold13 : .MainTextRegular13)
                        .foregroundStyle(!closeTapped ? .black03 : .gray03)
                })
                Spacer()
            }
            Divider()
        }
        .padding(.horizontal, 32.5)
    }
    
    

}





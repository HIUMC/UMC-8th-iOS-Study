//
//  FindRouteView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 5/20/25.
//

import SwiftUI
import CoreLocation

struct FindRouteView : View {
    @Bindable var locationManager: LocationManager
    @Binding var isFindStore: Bool
    
    @State var isRouteLoading: Bool = false
    @State var showSource: Bool = false
    @State var showDest: Bool = false
    @State var source: FindRouteModel = .init(placeName: "", address: "")
    @State var destination: FindRouteModel = .init(placeName: "", address: "")
    @FocusState private var isFocused: Bool
    
    @StateObject var viewModel: FindRouteViewModel = .init()
    @EnvironmentObject var parsingViewModel: JSONParsingViewModel
    @EnvironmentObject var mapViewModel: MapViewModel
    

    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                topView
                if showSource {
                    sourceSearchResult
                } else if showDest {
                    destSearchResult
                } else {
                    Spacer()
                }
            }
            if isRouteLoading {
                Color.black.opacity(0.5).ignoresSafeArea()
                ProgressView("경로 검색 중...")
                    .tint(.green00)
            }
        }
    }
    
    
    private var topView: some View {
        VStack {
            HStack {
                Text("출발")
                    .font(.MainTextSemiBold16)
                Button(action: {
                    Task {
                        let placeInfo = await viewModel.resolveAddress(for: locationManager.currentLocation ?? CLLocation(latitude: 37.556809, longitude: 126.924196))
                        source.address = placeInfo
                        source.placeName = placeInfo
                    }
                }, label: {
                    Text("현재 위치")
                        .foregroundStyle(.white)
                        .font(.pretend(type: .semibold, size: 13))
                        .frame(width: 58, height: 30)
                        .background(.brown01)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                })
                TextField("매장명 또는 주소", text: $source.placeName)
                    .focused($isFocused)
                    .textFieldStyle(.roundedBorder)
                Button(action: {
                    if !source.placeName.isEmpty {
                        viewModel.searchWithKeyword(query: source.placeName)
                        showDest = false
                        showSource = true
                    }
                    
                }) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.black)
                }
            }
            HStack {
                Text("도착")
                    .font(.MainTextSemiBold16)
                TextField("매장명 또는 주소", text: $destination.placeName)
                    .focused($isFocused)
                    .textFieldStyle(.roundedBorder)
                Button(action: {
                    if !destination.placeName.isEmpty {
                        parsingViewModel.sortAddress(by: destination.placeName)
                        showDest = true
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.black)
                }
            }
            Button(action: {
                
                isFocused = false
                
                Task {
                    isRouteLoading = true
                    defer { isRouteLoading = false }
                    
                    do {
                        guard let sourceCoord = try await viewModel.addressToCoordinate(address: source.address),
                              let destCoord = try await viewModel.addressToCoordinate(address: destination.address) else {
                            print("좌표 변환 실패")
                            return
                        }
                        mapViewModel.routePoints = try await viewModel.requestOsrmRoute(source: sourceCoord, dest: destCoord)
                        isFindStore.toggle()
                    } catch {
                        print("경로 요청 중 에러 발생")
                    }
                }
            }, label: {
                Text("경로 찾기")
                    .foregroundStyle(.white)
                    .font(.MainTextMedium16)
                    .frame(maxWidth: .infinity, minHeight: 38)
                    .background(.green00)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
        }
        .padding(.horizontal, 31)
        .padding(.vertical, 20)
    }
    
    
    private var sourceSearchResult: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.searchResults, id: \.self) { store in
                    makeCell(placeName: store.placeName, address: store.addressName)
                    .onTapGesture {
                        source.placeName = store.placeName
                        source.address = store.addressName
                        showSource = false
                        showDest = false
                    }
                    Divider()
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private var destSearchResult: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 16) {
                ForEach(parsingViewModel.sortedData, id: \.storeId) { store in
                    makeCell(placeName: store.storeName, address: store.address)
                        .onTapGesture {
                            destination.placeName = store.storeName
                            destination.address = store.address
                            parsingViewModel.sortedData = [store]
                        }
                    Divider()
                }
            }
        }
    }
    
    @ViewBuilder
    func makeCell(placeName: String, address: String) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(placeName)
                    .font(.MainTextMedium16)
                    .foregroundStyle(.black)
                Text(address)
                    .font(.pretend(type: .medium, size: 13))
                    .foregroundStyle(.gray04)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            Spacer()
        }
    }
}

#Preview {
    //FindRouteView()
}

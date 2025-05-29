//
//  FindRouteView.swift
//  Starbucks
//
//  Created by 박정환 on 5/22/25.
//


import SwiftUI
import CoreLocation

struct FindRouteView : View {
    @Bindable var locationManager: LocationManager
    @State var showSource: Bool = false
    @State var showDest: Bool = false
    @State var source: String = ""
    @State var destination: String = ""
    
    @StateObject var viewModel: FindRouteViewModel = .init()
    @EnvironmentObject var parsingViewModel: JSONParsingViewModel
    

    
    var body: some View {
        VStack(spacing: 28) {
            
            topView
            
            if showSource {
                sourceSearchResult
            } else if showDest {
                destSearchResult
            } else {
                Spacer()
            }
        }
        
    }
    
    /*
    private var topView: some View {
        VStack {
            HStack {
                Text("출발")
                    .font(.mainTextSemiBold16)
                Button(action: {
                    Task {
                        source = await viewModel.resolveAddress(for: locationManager.currentLocation ?? CLLocation(latitude: 37.556809, longitude: 126.924196))
                    }
                }, label: {
                    Text("현재 위치")
                        .foregroundStyle(.white)
                        .font(.pretend(type: .semibold, size: 13))
                        .frame(width: 58, height: 30)
                        .background(.brown01)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                })
                TextField("매장명 또는 주소", text: $source)
                    .textFieldStyle(.roundedBorder)
                Button(action: {
                    viewModel.searchWithKeyword(query: source)
                    showDest = false
                    showSource = true
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
                TextField("매장명 또는 주소", text: $destination)
                    .textFieldStyle(.roundedBorder)
                Button(action: {
                    parsingViewModel.sortAddress(by: destination)
                    showDest = true
                }) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.black)
                }
            }
            Button(action:  {
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
    */
    
    private var topView: some View {
        VStack {
            HStack {
                Text("출발")
                    .font(.mainTextSemiBold16)
                
                Button(action: {
                    start = viewModel.address
                }, label: {
                    Text("현재위치")
                        .font(.mainTextSemiBold13)
                        .foregroundStyle(.white01)
                        .frame(width: 58, height: 30)
                        .background(Color.brown01)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                })
                
                TextField("출발지 입력", text: $start)
                    .padding(EdgeInsets(top: 7, leading: 9, bottom: 7, trailing: 9))
                    .border(.gray01, width: 1)
                    .font(.mainTextRegular13)
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.black)
                })
            }
            
            HStack {
                Text("도착")
                    .font(.mainTextSemiBold16)
                
                TextField("매장명 또는 주소", text: $end)
                    .padding(EdgeInsets(top: 7, leading: 9, bottom: 7, trailing: 9))
                    .border(.gray01, width: 1)
                    .font(.mainTextRegular13)
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.black)
                })
            }
            
            Button(action:  {
            }, label: {
                Text("경로 찾기")
                    .foregroundStyle(.white)
                    .font(.MainTextMedium16)
                    .frame(maxWidth: .infinity, minHeight: 38)
                    .background(.green00)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
            
            Spacer()
        }.padding(.horizontal, 31)
    }
}
    
    private var sourceSearchResult: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.searchResults, id: \.self) { store in
                    makeCell(placeName: store.placeName, address: store.addressName)
                    .onTapGesture {
                        source = store.placeName
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
                            destination = store.storeName
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
                    .font(.mainTextMedium16)
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

//
//  FindPathView.swift
//  StarbuckApp
//
//  Created by 박병선 on 5/22/25.
//경고 버튼은 바디에서 관리할 것, Placename이랑 Address를 하나의 객체로 묶어서 정의하기,
//도착지, 출발지 리스트를 ScrollView로 관리하기 각 매장마다 셀을 만들 어? -> @ViewBuilder
//경로 찾기에서 Task로 관리 async, await로 구현하지 않으면
//addressToCoordinate라는 함수????
//경로를 포인트로 주는데 필요한 파라미터만 알아서 디코딩해서 가져올 수 있음
//워크북의 request async
/*
 requestOSRMresponse라는 함수로 OSRM서버의 응답 받아오기
 */
import SwiftUI

struct FindPathView: View{
    
    @StateObject private var viewModel = PlaceSearchViewModel()
    @State private var showStartSearchResults = false
    
    @StateObject private var locationManager = LocationManager()
    @State private var useCurrentLocation = true
    @State private var startText = ""
    @State private var destinationText = ""
    @StateObject var destVM = DestinationSearchViewModel()
    
    
    var body: some View{
        HStack(spacing: 8) {
            Text("출발")
                .font(.mainTextSemiBold16)
                .foregroundColor(Color("black03"))
            /*Button(action: {
             useCurrentLocation = true
             locationManager.requestCurrentLocation()
             })
             */
            Button(action: {
                if let coord = locationManager.currentLocation?.coordinate {
                    viewModel.searchKeyword(query: viewModel.searchText, coordinate: coord)
                }
            })
            {
                Text("현재위치")
                    .font(.subheadline)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(useCurrentLocation ? Color("brown01") : Color.gray.opacity(0.2))
                    .foregroundColor(Color("white01"))
                    .cornerRadius(8)
            }
            
            //검색 버튼을 눌렀을 때만 받아오도록 구현하기
            TextField("출발지 입력", text: $startText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: startText, initial: true){ oldValue, newValue in
                    viewModel.searchText = newValue
                    showStartSearchResults = true
                }
            
            //어쩔 수가 없었어...
                .onChange(of: locationManager.currentAddress){
                    newAddress in if useCurrentLocation {
                        startText = newAddress
                    }
                }
            
                .alert("검색 결과가 존재하지 않습니다.", isPresented: $viewModel.isShowingNoResultAlert) {
                    Button("확인", role: .cancel) { }
                }
            
            Button {
                print("출발지 검색")
            } label: {
                Image(systemName: "magnifyingglass")
            }
        }
        .padding(.horizontal)
        
        //출발지 검색 결과
        //list하나하나를 버튼으로 구현해도 된대
        if showStartSearchResults {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(viewModel.searchResults) { place in
                    VStack(alignment: .leading) {
                        Text(place.place_name)
                            .font(.mainTextMedium16)
                            .foregroundColor(Color("black01"))
                        Text(place.address_name)
                            .font(.mainTextMedium12)
                            .foregroundColor(Color("gray04"))
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.05))
                    //.cornerRadius(8)
                    .onTapGesture {
                        startText = place.place_name
                        viewModel.searchText = place.place_name//동기화
                        viewModel.selectedPlace = place
                        showStartSearchResults = false
                    }
                    
                }
            }
            .padding(.horizontal)
        }
        
        
        // MARK: - 도착지
        HStack(spacing: 8) {
            Text("도착")
                .font(.mainTextSemiBold16)
                .foregroundColor(Color("black03"))
            TextField("매장명 또는 주소", text: $destinationText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button {
                destVM.search()
                print("도착지 검색")
            } label: {
                Image(systemName: "magnifyingglass")
            }
            if destVM.showResult {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(destVM.filteredStores, id: \.self) { store in
                        VStack(alignment: .leading) {
                            Text(store.properties.storeName)
                            Text(store.properties.address)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .onTapGesture {
                            destVM.select(store)
                        }
                    }
                }
            }
            // .padding(.horizontal)
            
            //Spacer()
            
            // MARK: - 경로 찾기 버튼
            Button(action: {
                print("경로 찾기 실행")
            }) {
                Text("경로 찾기")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color("green01"))
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
            .navigationTitle("매장 찾기")
            .navigationBarTitleDisplayMode(.inline)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        //.frame(maxHeight: .infinity, alignment: .top)
        //.navigationTitle("매장 찾기")
        // .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FindPathView()
}

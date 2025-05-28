//
//  DirectionsSearchView.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/19/25.
//
// 출발지 도착지 입력 UI + 경로 검색 버튼
// 

import Foundation
import CoreLocation
import SwiftUI

struct DirectionsSearchView: View {
    @State private var selectedDeparturePlace: Place? = nil
    @State private var didTapCurrentLocation: Bool = false
    @State private var didSetCurrentLocationOnce = false
    @State private var searchTextChangedManually = false
    @State private var showRouteAlert = false
    @State private var alertMessage = ""
    @State private var lastLocation: CLLocation?
    @State private var searchText = ""
    @State private var arrivalText = ""
    @State private var departureText: String = ""
    @ObservedObject var viewModel: DirectionsSearchViewModel
    @ObservedObject var storeDataManager: StoreDataManager
    @StateObject private var destinationVM = DestinationSearchViewModel()
    @StateObject private var placeSearchVM = PlaceSearchViewModel()
    
    
    
    var body: some View {
        VStack(spacing: 16) {
            // 출발지 입력
            VStack(alignment: .leading, spacing: 4) {
                Text("출발")
                    .font(.mainTextSemibold16)
                HStack(spacing: 8) {
                    Button(action: {
                        //버튼 누르면 true 전환 후 현재 위치 요청
                        didTapCurrentLocation = true
                        storeDataManager.requestLocation()
                    }) {
                        Text("현재위치")
                            .font(.caption)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color("brown01"))
                            .foregroundColor(.white)
                            .cornerRadius(6)
                    }
                    
                    TextField("출발지 입력", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(action: {
                        placeSearchVM.search(keyword: searchText)
                        selectedDeparturePlace = nil //이전에 선택한 출발지 초기화
                    }) {
                        Image("magnifyingglass")
                    }
                }
            }
            
            // 도착지 입력
            VStack(alignment: .leading, spacing: 4) {
                Text("도착")
                    .font(.mainTextSemibold16)
                HStack(spacing: 8) {
                    TextField("매장명 또는 주소", text: $arrivalText)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(action: {
                        destinationVM.query = arrivalText
                        destinationVM.search(in: storeDataManager.stores)
                    }) {
                        Image("magnifyingglass")
                    }
                }
            }
            
            // 경로 찾기 버튼
            Button(action: {
                print("경로 찾기 눌림")
                if let startPlace = selectedDeparturePlace {
                    if let end = storeDataManager.stores.first(where: { $0.name == arrivalText }) {
                        // 출발지 도착지 유효하면 -> 좌표로 전환
                        if let lat = Double(startPlace.y), let lon = Double(startPlace.x) {
                            //출발지 좌표
                            let startCoord =  CLLocationCoordinate2D(latitude: lat, longitude: lon)
                            //도착지 좌표
                            let endCoord = CLLocationCoordinate2D(latitude: end.latitude, longitude: end.longitude)
                            viewModel.searchRoute(from: startCoord, to: endCoord)
                        } else {
                            alertMessage = "출발지 좌표 변환 실패"
                            showRouteAlert = true
                        }
                    } else {
                        alertMessage = "도착지가 등록된 매장이 아닙니다."
                        showRouteAlert = true
                    }
                } else {
                    alertMessage = "출발지를 선택해주세요"
                    showRouteAlert = true
                }
            }) {
                Text("경로 찾기")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("green00"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .frame(height: 22)
            }
            .padding(.top, 16)
            
            if !destinationVM.results.isEmpty {
                List(destinationVM.results) { store in
                    Button {
                        arrivalText = store.name
                        destinationVM.results = []
                    } label: {
                        VStack(alignment: .leading) {
                            Text(store.name)
                            Text(store.address)
                                .font(.mainTextMedium12)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .listStyle(.plain)
                .frame(height: 250)
            }
            
            // 출발지 검색 결과
            if !placeSearchVM.results.isEmpty {
                List(placeSearchVM.results) { place in
                    Button {
                        selectedDeparturePlace = place
                        searchText = place.placeName
                        placeSearchVM.results = []
                    } label: {
                        VStack(alignment: .leading) {
                            Text(place.placeName)
                            Text(place.addressName)
                                .font(.mainTextMedium12)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .listStyle(.plain)
                .frame(height: 250)
            }
            
            Spacer()
        }
        .padding()
        .alert(isPresented: $showRouteAlert) {
            Alert(title: Text("알림"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
        }
        // 출발지 텍스트 필드 업데이트
        .onReceive(placeSearchVM.$selectedPlace) { place in
            if let place = place {
                searchText = place.placeName
                departureText = place.addressName
            }
        }
        
    }
}
        
    

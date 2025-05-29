//
//  FindLocationView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/27/25.
//


import SwiftUI
import CoreLocation
import Moya
import _Concurrency

struct OSRMResponse: Decodable {
    let routes: [Route]

    struct Route: Decodable {
        let geometry: Geometry
    }

    struct Geometry: Decodable {
        let coordinates: [[Double]] // [longitude, latitude]
    }
}

struct FindLocationView: View {

    @StateObject private var viewModel = FindLocationViewModel()
    @ObservedObject private var locationManager = LocationManager.shared
    @State private var shouldUpdateFromLocation = false

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack {
                HStack {
                    Text("출발")
                        .foregroundStyle(.black01)

                    Button(action: {
                        locationManager.shouldGeocodeOnce = true
                        locationManager.startUpdatingLocation()
                        shouldUpdateFromLocation = true
                    }) {
                        Image("currentlocation")
                            .resizable()
                            .frame(width: 58, height: 30)
                    }

                    ZStack {
                        Image("rectangle1")
                            .resizable()
                            .frame(width: 237, height: 30)
                        TextField("출발지 입력", text: $viewModel.startplace)
                            .foregroundStyle(.grey04)
                            .padding()
                    }

                    Button(action: {
                        viewModel.performSearch()
                    }) {
                        Image("search2")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }

                HStack{
                    Text("도착")
                        .foregroundStyle(.black01)

                    ZStack {
                        Image("rectangle1")
                            .resizable()
                            .frame(width: 303, height: 30)
                        TextField("매장명 또는 주소", text: $viewModel.arriveplace)
                            .foregroundStyle(.grey04)
                            .padding()
                    }

                    Button(action: {
                       
                    }) {
                        Image("search2")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }

                Button(action: {
                    runRouteSearch()
                }) {
                    Image("findway")
                        .resizable()
                        .frame(width: 375, height: 38)
                }

                if viewModel.isLoadingRoute {
                    ProgressView("경로 검색 중…")
                        .padding()
                }

                if viewModel.isSearching {
                    List(viewModel.storeResults) { place in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(place.name)
                                .font(.headline)
                            Text(place.address)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 4)
                        .onTapGesture {
                            viewModel.startplace = place.name
                            viewModel.isSearching = false
                        }
                    }
                    .frame(height: 250)
                }

                if viewModel.isArriveSearching {
                    if viewModel.storeResults.isEmpty {
                        Text("검색 결과가 없습니다.")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        List(viewModel.storeResults) { store in
                            VStack(alignment: .leading) {
                                Text(store.name)
                                    .font(.headline)
                                Text(store.address)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .onTapGesture {
                                viewModel.arriveplace = store.name
                                viewModel.isArriveSearching = false
                            }
                        }
                        .frame(height: 250)
                    }
                }
            }
        }
        .onChange(of: locationManager.currentAddress) {
            if shouldUpdateFromLocation {
                viewModel.startplace = locationManager.currentAddress
                shouldUpdateFromLocation = false
            }
        }
    }
    // ✅ Helper 메서드 분리
    private func runRouteSearch() {
        DispatchQueue.global(qos: .userInitiated).async {
            viewModel.findWalkingRouteLegacy(
                startQuery: viewModel.startplace,
                endQuery: viewModel.arriveplace
            )
        }
    }



}

#Preview {
    FindLocationView()
}

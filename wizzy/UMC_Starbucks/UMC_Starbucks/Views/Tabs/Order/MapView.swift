//
//  MapView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/3/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Bindable private var locationManager = LocationManager.shared
    @Bindable private var viewModel: MapViewModel = .init()
    @StateObject private var parsingViewModel = JSONParsingViewModel()
    @Namespace var mapScope
    @State private var hasMapMoved = false
    @State private var selectedCoordinate: CLLocationCoordinate2D? = nil
    @State private var cameraCenterCoordinate: CLLocationCoordinate2D? = nil
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
                    Map(position: $viewModel.cameraPosition, scope: mapScope) {
                        ForEach(viewModel.makers, id: \.id, content: { marker in
                            Annotation(marker.title, coordinate: marker.coordinate, content: {
                                Image("marker")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 30, height: 40)
                                    .foregroundStyle(Color.green02)
                            })
                        })
                        
                        UserAnnotation()
                    }
                    
                    HybridMapView(
                        selectedCoordinate: $selectedCoordinate,
                        cameraCenter: $cameraCenterCoordinate,
                        hasMoved: $hasMapMoved
                    )
                    .allowsHitTesting(false) //사용자의 터치 이벤트를 무시
                    .frame(width: 1, height: 1)
                    .opacity(0)
                    
                    MapUserLocationButton(scope: mapScope)
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.clear)
                                .stroke(Color.red, style: .init(lineWidth: 2))
                        })
                        .offset(x: -10, y: -10)
                    
                    if hasMapMoved {
                        Button("이 지역 검색") {
                            if let center = selectedCoordinate {
                                let centerLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
                                let nearbyStores = parsingViewModel.allStores.filter { store in
                                    let storeLocation = CLLocation(latitude: store.properties.ycoordinate,
                                                                   longitude: store.properties.xcoordinate)
                                    let distance = centerLocation.distance(from: storeLocation)
                                    return distance <= 10_000 // 10km
                                }
                                viewModel.updateMarkers(from: nearbyStores)
                                hasMapMoved = false
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 4)
                        .padding(.top, 30)
                        
                        Text("hasMapMoved: \(hasMapMoved.description)")
                            .foregroundColor(.gray)
                            .padding(.bottom, 100)
                    }
                }
        .padding(.horizontal, 23)
                .mapScope(mapScope)
                .onAppear {
                    cameraCenterCoordinate = locationManager.currentLocation?.coordinate
                    parsingViewModel.loadMyProfile { result in
                        switch result {
                        case .success(_):
                            if let userLocation = locationManager.currentLocation {
                                let nearbyStores = parsingViewModel.allStores.filter { store in
                                    let storeLocation = CLLocation(latitude: store.properties.ycoordinate,
                                                                   longitude: store.properties.xcoordinate)
                                    let distance = userLocation.distance(from: storeLocation)
                                    return distance <= 10_000 // 10km
                                }
                                viewModel.updateMarkers(from: nearbyStores)
                            } else {
                                print("사용자 위치 정보를 가져오지 못했습니다.")
                            }
                        case .failure(let error):
                            print(" 에러 발생: \(error)")
                        }
                    }
                }
        
        /*
        Map(position: $viewModel.cameraPosition) {
            ForEach(viewModel.makers, id: \.id) { marker in
                Annotation(marker.title, coordinate: marker.coordinate, content: {
                    Image("marker")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 30, height: 40)
                        .foregroundStyle(Color.green02)
                })
            }
        }
        .onAppear {
            parsingViewModel.loadMyProfile { result in
                switch result {
                case .success(_):
                    viewModel.updateMarkers(from: parsingViewModel.allStores)
                case .failure(let error):
                    print(" 에러 발생: \(error)")
                }
            }
        }
        */
    }
}

#Preview {
    MapView()
}

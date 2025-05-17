//
//  StoreMapView.swift
//  StarbucksApp
//
//  Created by 고석현 on 5/1/25.
//
import Foundation
import Observation
import MapKit
import CoreLocation
import SwiftUI


struct StoreMapView: View {
    @Bindable var viewModel: MapViewModel
    @Bindable var locationManager: LocationManager
    @Namespace var mapScope
    @State private var hasMovedMap: Bool = false
    @State private var cameraInitialized: Bool = false
    @State private var mapCenter: CLLocationCoordinate2D?

    var body: some View {
        MapReader { reader in
            ZStack(alignment: .bottomTrailing) {
                Map(position: $viewModel.cameraPosition, scope: mapScope) {
                    if let userLocation = locationManager.currentLocation?.coordinate {
                        ForEach(viewModel.markers, id: \.id, content: { marker in
                            Annotation(marker.title, coordinate: marker.coordinate) {
                                Image("marker")
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 35, height: 48)
                            }
                        })
                    }

                    UserAnnotation()
                }

                if hasMovedMap {
                    VStack(alignment: .center) {
                        HStack {
                            Spacer()
                            Button(action: {
                                let screenCenter = CGPoint(x: 390 / 2, y: 844 / 2)
                                if let center = reader.convert(screenCenter, from: .local) {
                                    viewModel.updateMarkers(around: center)
                                    hasMovedMap = false
                                    print("📍뭔가 바뀌네요?")
                                }
                            }) {
                                Text("이 지역 검색")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .shadow(radius: 2)
                            }
                            Spacer()
                        }
                        .padding(.top, 20)
                        Spacer()
                    }
                }
            }
            .mapScope(mapScope)
//            .onAppear {
//                if let userLocation = locationManager.currentLocation?.coordinate {
//                    viewModel.updateCameraPosition(for: userLocation)
//                    viewModel.updateMarkers(around: userLocation)
//                }
//            }
            .onChange(of: viewModel.cameraPosition) { _, newValue in
                // 처음 한 번은 무시
                if !cameraInitialized {
                    cameraInitialized = true
                    return
                }

                // 여기 도달했으면 드래그 or 유저 조작이라 판단
                hasMovedMap = true
            }
        }
    }
}



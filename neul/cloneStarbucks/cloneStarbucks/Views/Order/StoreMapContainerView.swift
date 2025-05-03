//
//  StoreMapView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/29/25.
//
import SwiftUI
import MapKit

struct StoreMapContainerView: View {
    
    @EnvironmentObject var viewModel: MapViewModel
    @Bindable var locationManager: LocationManager
    @Namespace var mapScope
    @State private var cameraCenter: CLLocationCoordinate2D? = nil
    @State private var hasMovedMap: Bool = false
    @State private var markerUpdate: Bool = true
    @State var isMapReady: Bool = false
    @ObservedObject var mapState: StoreMapStateViewModel
    
    
    var body: some View {
        ZStack(alignment: .top) {
            
            if isMapReady, let region = viewModel.initialRegion {
                UIKitMapView(cameraCenter: $cameraCenter, hasMovedMap: $hasMovedMap, markers: $viewModel.markers, markerUpdate: $markerUpdate, mapState: mapState, initialRegion: region)
                    .ignoresSafeArea(edges: .bottom)
            } else {
                Color.white01
                    .overlay {
                        ProgressView("지도 불러오는 중 ..")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            
            if hasMovedMap {
                Button(action: {
                    if let center = cameraCenter {
                        viewModel.updateMarkers(around: center)
                        hasMovedMap = false
                        markerUpdate = true
                    }
                    
                }, label: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 88, height: 36)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                        .overlay {
                            Text("이 지역 검색")
                                .font(.pretend(type: .medium, size: 13))
                                .foregroundColor(.gray06)
                        }
                    
                })
                .padding(.top, 20)
            }
            
                


                

            }
            .mapScope(mapScope)
            .onChange(of: locationManager.currentLocation) { _, newLocation in
                guard !isMapReady else { return }
                
                DispatchQueue.main.async {
                    if let coordinate = newLocation?.coordinate {
                        cameraCenter = coordinate
                        viewModel.makeInitialRegion(for: coordinate)
                        isMapReady = true
                        viewModel.updateMarkers(around: coordinate)
                    }
                }
                
            }
    }
    
}


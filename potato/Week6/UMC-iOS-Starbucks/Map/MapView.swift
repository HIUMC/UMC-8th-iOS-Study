//
//  MapView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 5/1/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var viewModel: MapViewModel = .init()
    @Bindable private var locationManager: LocationManager = .shared
    @State private var searchText = ""
    
    let showsUserLocationButton: Bool
    @Namespace var mapScope
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(position: $viewModel.cameraPosition, scope: mapScope) {
                ForEach(viewModel.nearbyMarkers, id: \.id, content: { marker in
                    Annotation(marker.title, coordinate: marker.coordinate, content: {
                        Image(.marker)
                        //                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 36, height: 48)
                        //                            .foregroundStyle(Color.red)
                    })
                })
                
                UserAnnotation()
            }
            .task {
                viewModel.userLocation = locationManager.currentLocation
                
                viewModel.loadStoresFromJson(filename: "Starbucks.geojson")

                viewModel.updateFromLocation(locationManager.currentLocation)
            }
            .onChange(of: locationManager.currentLocation) { oldLocation, newLocation in
                viewModel.userLocation = newLocation
            }

            if showsUserLocationButton {
                // 누르면 현재 위치로 돌아오는 버튼
                MapUserLocationButton(scope: mapScope)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.clear)
                    })
                    .offset(x: -10, y: -10)
            }
        }
        .mapScope(mapScope)
    }
}

#Preview {
    MapView(showsUserLocationButton: false)
}

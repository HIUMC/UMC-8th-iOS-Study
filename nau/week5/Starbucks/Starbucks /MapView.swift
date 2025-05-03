//
//  MapView.swift
//  Starbucks
//
//  Created by nau on 5/3/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @Bindable private var locationManager = LocationManager.shared
    @Bindable private var viewModel: MapViewModel = .init()
    
    @State private var lastKnownLocation: CLLocationCoordinate2D?
    @State private var showSearchButton: Bool = false
    
    @Namespace var mapScope
    
    @State private var showEnteredAlert: Bool = false
    @State private var showExitedAlert: Bool = false
    
    @State private var hasMovedMap = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(position: $viewModel.cameraPosition, scope: mapScope) {
                ForEach(viewModel.makers, id: \.id, content: { marker in
                    Annotation(marker.title, coordinate: marker.coordinate, content: {
                        Image(.marker)
                            .resizable()
                            .frame(width: 35, height: 48)
                    })
                })
                
                UserAnnotation()
                
                MapCircle(center: viewModel.geofenceCoordinate, radius: viewModel.geofenceRadius)
                    .foregroundStyle(Color.blue.opacity(0.2))
                    .stroke(Color.blue, lineWidth: 2)
            }
            .onChange(of: locationManager.didEnterGeofence) { _, entered in
                if entered {
                    showEnteredAlert = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showEnteredAlert = false
                        locationManager.didEnterGeofence = false
                    }
                }
            }
            
            .onChange(of: locationManager.didExitGeofence) { _, exited in
                if exited {
                    showExitedAlert = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showExitedAlert = false
                        locationManager.didExitGeofence = false
                    }
                }
            }
            
            /*if hasMovedMap {
                Button(action: {
                    // 이 지역에서 재검색하는 로직
                    print("이 지역 검색 버튼 눌림")
                }) {
                    Text("이 지역 검색")
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 5)
                }
                .padding()
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }*/
            
            MapUserLocationButton(scope: mapScope)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.clear)
                        .stroke(Color.red, style: .init(lineWidth: 2))
                })
                .offset(x: -10, y: -10)
            
            if showEnteredAlert {
                HStack {
                    Spacer()
                    Text("\(viewModel.geofenceIdentifier) 진입함")
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5)
                    Spacer()
                }
            }

            if showExitedAlert {
                HStack {
                    Spacer()
                    Text("\(viewModel.geofenceIdentifier) 벗어남")
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5)
                    Spacer()
                }
            }
        }
        .mapScope(mapScope)
        /*.overlay(alignment: .top, content: {
            VStack(content: {
                HStack(spacing: 10) {
                    Text("속도: \(locationManager.currentSpeed, specifier: "%.2f") m/s")
                    
                    Text("방향: \(locationManager.currentDirection, specifier: "%.0f")°")
                }
            })
        })*/
    }
}

#Preview {
    MapView()
}

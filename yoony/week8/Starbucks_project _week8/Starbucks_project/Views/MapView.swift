//
//  MapView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/3/25.
//
import SwiftUI
import MapKit

struct MapView: View {

    @Bindable private var locationManager = LocationManager.shared
    @Bindable private var viewModel: MapViewModel = .init()

    @ObservedObject var findLocationViewModel: FindLocationViewModel
    
    @State private var lastKnownLocation: CLLocationCoordinate2D?
    @State private var showSearchButton: Bool = false
    @Namespace var mapScope

    @State private var showEnteredAlert: Bool = false
    @State private var showExitedAlert: Bool = false
    @State private var addressText: String = ""

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(position: $viewModel.cameraPosition, scope: mapScope) {
                ForEach(viewModel.makers, id: \..id) { marker in
                    Annotation(marker.title, coordinate: marker.coordinate) {
                        Image(systemName: "mappin.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(Color.red)
                    }
                }

                UserAnnotation()

                MapCircle(center: viewModel.geofenceCoordinate, radius: viewModel.geofenceRadius)
                    .foregroundStyle(Color.blue.opacity(0.2))
                    .stroke(Color.blue, lineWidth: 2)

                // ✅ Polyline 경로 표시
                if !findLocationViewModel.routeCoordinates.isEmpty {
                                    MapPolyline(coordinates: findLocationViewModel.routeCoordinates)
                                        .stroke(.blue, lineWidth: 5)
                                }
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

            MapUserLocationButton(scope: mapScope)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.clear)
                        .stroke(Color.red, style: .init(lineWidth: 2))
                }
                .offset(x: -10, y: 60)

            VStack(alignment: .trailing, spacing: 8) {
                TextField("현재 주소", text: $addressText)
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal)

                Button("📍 현재 위치 가져오기") {
                    locationManager.requestAuthorization()
                    locationManager.startUpdatingLocation()
                    addressText = locationManager.currentAddress
                }
                .padding(8)
                .background(Color.blue.opacity(0.8))
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal)
            }
            .padding(.bottom, 100)

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
        .onChange(of: locationManager.currentAddress) {
            addressText = locationManager.currentAddress
        }

    }
}


#Preview {
    MapView(findLocationViewModel: FindLocationViewModel())
}

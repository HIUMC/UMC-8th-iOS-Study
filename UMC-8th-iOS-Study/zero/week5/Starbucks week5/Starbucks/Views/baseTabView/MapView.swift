//
//  MapView.swift
//  Starbucks
//
//  Created by 김영택 on 5/3/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var viewModel = MapViewModel()
    @StateObject private var locationManager: LocationManager = .shared
    
    @State private var lastKnownLocation: CLLocationCoordinate2D?
   
    @Namespace var mapScope // 맵 관련 스코프 바인딩용
    
    @State private var hasMovedMap = false // 사용자가 지도를 움직였는지..
    @State private var hasInitializedCameraPosition = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(position: $viewModel.cameraPosition, scope: mapScope) {
                // 마커 표시
                ForEach(viewModel.makers, id: \.id, content: { marker in
                    Annotation(marker.title, coordinate: marker.coordinate, content: {
                        Image(.marker)
                            .resizable()
                            .frame(width: 35, height: 48)
                    })
                })
                
                // 내 위치에 점을 지도에 표시
                UserAnnotation()
          
            }
            
            .task {
                if !hasInitializedCameraPosition,
                   let location = LocationManager.shared.currentLocation {
                    viewModel.cameraPosition = .region(
                        MKCoordinateRegion(
                            center: location.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        )
                    )
                    hasInitializedCameraPosition = true
                }
            }
            // 지도 움직임 감지
            .onMapCameraChange(frequency: .onEnd) { context in
                let center = context.camera.centerCoordinate
                
                if let last = lastKnownLocation {
                    let movedDistance = CLLocation(latitude: last.latitude, longitude: last.longitude).distance(from: CLLocation(latitude: center.latitude, longitude: center.longitude))
                    
                    if movedDistance >= 50 {
                        hasMovedMap = true
                    }
                }
                lastKnownLocation = center
            }

            
            VStack {
                if hasMovedMap {
                    Button {
                        // 이 지역에서 재검색하는 로직
                        print("이 지역 검색 버튼 눌림")
                        if let newCenter = lastKnownLocation {
                            let location = CLLocation(latitude: newCenter.latitude, longitude: newCenter.longitude)
                            
                            viewModel.loadMarkersFromGeoJSON(userLocation: location)
                            
                            viewModel.cameraPosition = .region(
                                MKCoordinateRegion(center: newCenter, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
                            
                            hasMovedMap = false
                                
                        }
                    } label: {
                        Text("이 지역 검색")
                            .padding()
                            .background(.white)
                            .font(.PretendardRegular12)
                            .foregroundStyle(.gray)
                            .clipShape(.capsule)
                            .shadow(radius: 5)
                    }
                    .frame(width: 88)
                 
                }
                
                Spacer()
                
                // 오른쪽 아래에 내 위치로 이동 버튼 배치
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
    MapView()
}

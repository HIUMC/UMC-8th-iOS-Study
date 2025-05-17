import SwiftUI
import MapKit
import Foundation

struct MapView: View {
    @Bindable private var locationManager = LocationManager.shared
    @Bindable private var viewModel: MapViewModel = .init()
    @StateObject private var parsingViewModel = JSONParsingViewModel()
    
    @State private var hasMapMoved = false
    @State private var selectedCoordinate: CLLocationCoordinate2D? = nil
    @State private var cameraCenterCoordinate: CLLocationCoordinate2D? = nil
    
    var body: some View {
        ZStack(alignment: .top) {
            MapViewRepresentable(
                selectedCoordinate: $selectedCoordinate,
                cameraCenter: $cameraCenterCoordinate,
                hasMoved: $hasMapMoved,
                markers: $viewModel.makers
            )
            //.edgesIgnoringSafeArea(Edge.Set)
            
            VStack {
                if hasMapMoved {
                    Button("이 지역 검색") {
                        if let center = cameraCenterCoordinate {
                            print("👉 중심좌표: \(center.latitude), \(center.longitude)")
                            
                            let centerLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
                            let nearbyStores = parsingViewModel.allStores.filter { store in
                                let storeLocation = CLLocation(
                                    latitude: store.properties.ycoordinate,
                                    longitude: store.properties.xcoordinate
                                )
                                let distance = centerLocation.distance(from: storeLocation)
                                return distance <= 10_000
                            }
                            print("📍 전체 매장 수: \(parsingViewModel.allStores.count)")
                            print("📍 필터링된 매장 수: \(nearbyStores.count)")
                            
                            viewModel.updateMarkers(from: nearbyStores)
                            hasMapMoved = false
                        } else {
                            print("⚠️ cameraCenterCoordinate가 nil입니다.")
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 4)
                    .padding(.top, 30)
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        if let userLocation = locationManager.currentLocation?.coordinate {
                            cameraCenterCoordinate = userLocation
                        }
                    }) {
                        Image(systemName: "location.fill")
                            .foregroundColor(.white)
                            .padding()
                            .background(Circle().fill(Color.green02))
                    }
                    .padding(10)
                }
            }
        }
        .onAppear {
            cameraCenterCoordinate = locationManager.currentLocation?.coordinate
            parsingViewModel.loadMyProfile { result in
                switch result {
                case .success:
                    if let userLocation = locationManager.currentLocation {
                        let nearbyStores = parsingViewModel.allStores.filter { store in
                            let storeLocation = CLLocation(
                                latitude: store.properties.ycoordinate,
                                longitude: store.properties.xcoordinate
                            )
                            let distance = userLocation.distance(from: storeLocation)
                            return distance <= 10_000
                        }
                        viewModel.updateMarkers(from: nearbyStores)
                    } else {
                        print("사용자 위치 정보를 가져오지 못했습니다.")
                    }
                case .failure(let error):
                    print("에러 발생: \(error)")
                }
            }
        }
    }
}


#Preview {
    MapView()
}

//
//  MapViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/30/25.
//
import Foundation
import Observation
import MapKit
import CoreLocation
import SwiftUI


class MapViewModel: ObservableObject {
    let locationManager: LocationManager
    private let parser = JSONParsingViewModel()

    init(locationManager: LocationManager = LocationManager.shared) {
        self.locationManager = locationManager
        //loadStores()
    }
    @Published var markers: [Marker] = []
  //markers도 변경되면 UI가 갱신돼야 하므로 @Published 필요
    @Published var stores: [StoreFeature] = []
    
    var userLocation: CLLocation? {
        LocationManager.shared.currentLocation
    }
    
//ObservableObject에서 @Published가 없으면 UI가 자동 업데이트되지 않음
    @Published var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), // 초기값: 서울 중심
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    var didEnterGeofence: Bool = false
    let geofenceRadius: CLLocationDistance = 100

    //10km 이내의 매장 추출하기
    func loadNearbyStores(userLocation: CLLocation) {
           parser.loadStoreData { result in
               switch result {
               case .success(let storeModel):
                   let nearby = storeModel.features.filter {
                       let loc = CLLocation(latitude: $0.properties.yCoordinate,
                                            longitude: $0.properties.xCoordinate)
                       return userLocation.distance(from: loc) <= 10_000
                   }
                   DispatchQueue.main.async {
                       self.stores = nearby
                       self.markers = nearby.map {
                           Marker(coordinate: CLLocationCoordinate2D(
                               latitude: $0.properties.yCoordinate,
                               longitude: $0.properties.xCoordinate),
                                  title: $0.properties.storeName)
                       }
                   }
               case .failure(let error):
                   print("매장 데이터 불러오기 실패: \(error)")
               }
           }
       }

    //사용자의 현재 위치와 특정 매장 간의 거리를 계산하는 함수
    func distance(to store: StoreFeature) -> CLLocationDistance? {
        guard let userLocation else { return nil }//유저로케이션이 없으면 계산하지 않고 nil 반환

        let storeLocation = CLLocation(
            latitude: store.properties.yCoordinate,
            longitude: store.properties.xCoordinate
        )

        return userLocation.distance(from: storeLocation)
    }
    
   //현재 위치로부터 가까운 순서대로 매장(StoreFeature)을 정렬하는 함수야.(가까운 거리 순으로 정렬)
    func sortedStoresByDistance() -> [StoreFeature] {
        stores.sorted {
            let d1 = distance(to: $0) ?? Double.greatestFiniteMagnitude
            let d2 = distance(to: $1) ?? Double.greatestFiniteMagnitude
            return d1 < d2
        }
    }

    func updateMarkers(around userLocation: CLLocationCoordinate2D, within radius: CLLocationDistance = 10000) {
        print("업데이트마커 호출됨")
        print("현재 store 개수: \(stores.count)")

        markers = stores.compactMap { feature in
            let storeLocation = CLLocation(
                latitude: feature.properties.yCoordinate,
                longitude: feature.properties.xCoordinate
            )

            let userLoc = CLLocation(
                latitude: userLocation.latitude,
                longitude: userLocation.longitude
            )

            let distance = userLoc.distance(from: storeLocation)
            print("가게: \(feature.properties.storeName), 거리: \(distance)m")

            if distance <= radius {
                return Marker(
                    coordinate: CLLocationCoordinate2D(
                        latitude: feature.properties.yCoordinate,
                        longitude: feature.properties.xCoordinate
                    ),
                    title: feature.properties.storeName
                )
            } else {
                return nil
            }
        }

        print("생성된 markers 개수: \(markers.count)")
        for marker in markers {
            print("마커 제목: \(marker.title), 위치: \(marker.coordinate.latitude), \(marker.coordinate.longitude)")
        }
    }


}


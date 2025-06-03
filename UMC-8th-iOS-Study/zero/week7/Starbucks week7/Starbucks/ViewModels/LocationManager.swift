//
//  LocationManager.swift
//  Starbucks
//
//  Created by 김영택 on 5/3/25.
//

import Foundation
import CoreLocation
import MapKit
import Combine

class LocationManager: NSObject, ObservableObject {
    
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    
    @Published var currentLocation: CLLocation?
    @Published var currentHeading: CLHeading?
    @Published var currentSpeed: CLLocationSpeed = 0
    @Published var currentDirection: CLLocationDirection = 0
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var didEnterGeofence: Bool = false
    @Published var didExitGeofence: Bool = false
    
    // 새로 추가: 현재 위치 주소 저장용
    @Published var currentAddress: String = "주소를 가져오는 중..."
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.headingFilter = kCLHeadingFilterNone
        
        requestAuthorization()
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }

    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    func startUpdatingHeading() {
        locationManager.startUpdatingHeading()
    }

    func stopUpdatingHeading() {
        locationManager.stopUpdatingHeading()
    }

    func startMonitoringSignificantLocationChanges() {
        locationManager.startMonitoringSignificantLocationChanges()
    }

    func stopMonitoringSignificantLocationChanges() {
        locationManager.stopMonitoringSignificantLocationChanges()
    }

    func startMonitoringVisits() {
        locationManager.startMonitoringVisits()
    }

    func startMonitoringGeofence(center: CLLocationCoordinate2D,
                                 radius: CLLocationDistance,
                                 identifier: String) {
        let region = CLCircularRegion(center: center, radius: radius, identifier: identifier)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        locationManager.startMonitoring(for: region)
    }

    func stopMonitoringAllGeofences() {
        for region in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
    }
    
    // 역지오코딩 메서드
    func reverseGeocodeCurrentLocation() {
        guard let location = currentLocation else {
            DispatchQueue.main.async {
                self.currentAddress = "위치 정보를 가져올 수 없습니다."
            }
            return
        }

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("역지오코딩 실패: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.currentAddress = "주소를 가져올 수 없습니다."
                }
                return
            }

            if let placemark = placemarks?.first {
                var addressString = ""
                if let name = placemark.name {
                    addressString += name
                }
                if let locality = placemark.locality {
                    addressString += " \(locality)"
                }
                if let administrativeArea = placemark.administrativeArea {
                    addressString += " \(administrativeArea)"
                }
                DispatchQueue.main.async {
                    self.currentAddress = addressString
                }
            } else {
                DispatchQueue.main.async {
                    self.currentAddress = "주소 정보를 찾을 수 없습니다."
                }
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        handleAuthorization(manager.authorizationStatus)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleAuthorization(status)
    }

    private func handleAuthorization(_ status: CLAuthorizationStatus) {
        DispatchQueue.main.async {
            self.authorizationStatus = status
        }
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            startUpdatingLocation()
        default:
            stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latest = locations.last else { return }
        DispatchQueue.main.async {
            self.currentLocation = latest
            self.currentSpeed = max(latest.speed, 0)
            // 위치가 갱신될 때마다 역지오코딩 수행
            self.reverseGeocodeCurrentLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        DispatchQueue.main.async {
            self.currentHeading = newHeading
            self.currentDirection = newHeading.trueHeading > 0 ? newHeading.trueHeading : newHeading.magneticHeading
        }
    }

    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        print("방문 감지됨 - 좌표: \(visit.coordinate), 도착: \(visit.arrivalDate), 출발: \(visit.departureDate)")
    }

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        DispatchQueue.main.async {
            self.didEnterGeofence = true
            self.didExitGeofence = false
        }
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        DispatchQueue.main.async {
            self.didEnterGeofence = false
            self.didExitGeofence = true
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 오류: \(error.localizedDescription)")
    }
}

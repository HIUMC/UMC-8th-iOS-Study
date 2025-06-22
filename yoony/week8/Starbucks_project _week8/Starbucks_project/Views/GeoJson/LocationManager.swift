//
//  LocationManager.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/3/25.
//
import Foundation
import CoreLocation
import MapKit
import Observation

/// 현재 위치, 방향, 주소, 지오펜싱 등을 처리하는 위치 매니저 클래스
@Observable
class LocationManager: NSObject, ObservableObject {

    static let shared = LocationManager()  // 싱글톤

    // MARK: - CLLocationManager
    let locationManager = CLLocationManager()

    // MARK: - 상태 변수 (SwiftUI에서 추적 가능)
    var currentLocation: CLLocation?
    var currentHeading: CLHeading?
    var currentSpeed: CLLocationSpeed = 0
    var currentDirection: CLLocationDirection = 0
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    var didEnterGeofence: Bool = false
    var didExitGeofence: Bool = false
    var currentAddress: String = "" // ✅ 변환된 주소 (법정동/행정동) - 핵심 추가
    var shouldGeocodeOnce: Bool = false // ✅ 1회만 지오코딩할 수 있도록 제어

    // MARK: - 초기화
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.headingFilter = kCLHeadingFilterNone

        requestAuthorization()
        startUpdatingHeading()
        startUpdatingLocation()
    }

    // MARK: - 권한 요청
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }

    // MARK: - 위치 추적 시작/중지
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    // MARK: - 방향 추적
    func startUpdatingHeading() {
        locationManager.startUpdatingHeading()
    }

    func stopUpdatingHeading() {
        locationManager.stopUpdatingHeading()
    }

    // MARK: - Significant Change
    func startMonitoringSignificantLocationChanges() {
        locationManager.startMonitoringSignificantLocationChanges()
    }

    func stopMonitoringSignificantLocationChanges() {
        locationManager.stopMonitoringSignificantLocationChanges()
    }

    // MARK: - 방문 감지
    func startMonitoringVisits() {
        locationManager.startMonitoringVisits()
    }

    // MARK: - 지오펜싱 등록/해제
    func startMonitoringGeofence(center: CLLocationCoordinate2D,
                                 radius: CLLocationDistance,
                                 identifier: String) {
        let region = CLCircularRegion(center: center, radius: radius, identifier: identifier)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        locationManager.startMonitoring(for: region)
        print("지오펜스 등록됨: \(identifier)")
    }

    func stopMonitoringAllGeofences() {
        for region in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
    }

    // MARK: - 주소 변환 (위치 → 주소)
    private func reverseGeocode(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "ko_KR")) { placemarks, error in
            if let error = error {
                print("❌ 역지오코딩 에러: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.currentAddress = "주소를 찾을 수 없습니다"
                }
                return
            }

            guard let placemark = placemarks?.first else {
                DispatchQueue.main.async {
                    self.currentAddress = "주소 없음"
                }
                return
            }

            let address = [placemark.administrativeArea, placemark.locality, placemark.subLocality]
                .compactMap { $0 }
                .joined(separator: " ")

            DispatchQueue.main.async {
                self.currentAddress = address
                print("📍 현재 주소: \(address)")
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let latest = locations.last {
            DispatchQueue.main.async {
                self.currentLocation = latest
                self.currentSpeed = max(latest.speed, 0)

                if self.shouldGeocodeOnce {
                    self.reverseGeocode(location: latest)
                    self.shouldGeocodeOnce = false
                }
            }
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

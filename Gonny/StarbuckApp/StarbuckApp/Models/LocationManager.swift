//
//  CoreLocationManager.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/29/25.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject {
    
    static let shared = LocationManager()
    var userLocation: CLLocationCoordinate2D?
    
    // MARK: - CLLocationManager
    private let locationManager = CLLocationManager()
    
    // MARK: - Published Properties
    @Published var currentLocation: CLLocation?
    @Published var currentHeading: CLHeading?
    @Published var currentAddress: String = "" //7주차에 추가된 내용, 현재의 주소 입력
    
    @Published var currentSpeed: CLLocationSpeed = 0
    @Published var currentDirection: CLLocationDirection = 0
    
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    @Published var didEnterGeofence: Bool = false
    @Published var didExitGeofence: Bool = false
    
    // MARK: - Init
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.headingFilter = kCLHeadingFilterNone
        
        requestAuthorization()
        //startUpdatingLocation()
            //startUpdatingHeading()
        //위에 주석처리한 두 함수 때문에 위치가 계속 파싱이 되어버림(이 두 함수가 초기화 자리에 들어가있어서 그런거야!!)
    }
    
    // MARK: - 권한 요청
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }

    // MARK: - 위치 추적
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
 
    //7주차에 추가됨, 처음 한 번 버튼 눌렀을 때만 위치 반환
    func requestCurrentLocation() {
        currentLocation = nil//중복요청방지
        locationManager.requestLocation()
    }
    
  
    private var lastGeocodeTime: Date = .distantPast //마지막으로 주소를 요청한 시간을 기억하는 변수
    func reverseGeocodeIfNeeded(_ location: CLLocation){
        let now = Date()
        
        //마지막 요청이랑 지금 시간 차이가 3초보다 작으면 그냥 return
        guard now.timeIntervalSince(lastGeocodeTime)
                > 3 else { return }
        
        lastGeocodeTime = now //시간 업데이트
        reverseGeocode(location) // 실제 주소 요청 실행
    }
    
    private func reverseGeocode(_ location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                print("주소 변환 실패: \(error?.localizedDescription ?? "알 수 없음")")
                return
            }

            let city = placemark.locality ?? ""         // 시/군/구
            let dong = placemark.subLocality ?? ""// 법정동
            let parsedAddress = "\(city) \(dong)"
            DispatchQueue.main.async {
                self.currentAddress = parsedAddress
                print("주소 파싱 완료: \(parsedAddress)")
            }
        }
    }

    
    // MARK: - 방향 추적
    func startUpdatingHeading() {
        locationManager.startUpdatingHeading()
    }
    
    func stopUpdatingHeading() {
        locationManager.stopUpdatingHeading()
    }

    // MARK: - Significant Location Change
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

    // MARK: - 지오펜싱
    func startMonitoringGeofence(center: CLLocationCoordinate2D,
                                 radius: CLLocationDistance,
                                 identifier: String) {
        let region = CLCircularRegion(center: center,
                                      radius: radius,
                                      identifier: identifier)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        
        locationManager.startMonitoring(for: region)
        print("Monitoring regions: \(locationManager.monitoredRegions)")
    }

    func stopMonitoringAllGeofences() {
        for region in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
    }
}


// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    // 권한 변경 감지
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }

    // 위치 업데이트 감지 (기본 위치 추적 + Significant Change)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let latest = locations.last {
            DispatchQueue.main.async {
                self.currentLocation = latest
                self.currentSpeed = max(latest.speed, 0)
                self.reverseGeocodeIfNeeded(latest)
            }
        }
     
    }

    // 방향 감지
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        DispatchQueue.main.async {
            self.currentHeading = newHeading
            self.currentDirection = newHeading.trueHeading > 0 ? newHeading.trueHeading : newHeading.magneticHeading
        }
    }

    // 방문 감지 (visit monitoring)
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        print("방문 감지됨 - 좌표: \(visit.coordinate), 도착: \(visit.arrivalDate), 출발: \(visit.departureDate)")
    }

    // 지오펜싱: 진입
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        DispatchQueue.main.async {
            self.didEnterGeofence = true
            self.didExitGeofence = false
        }
    }

    // 지오펜싱: 이탈
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        DispatchQueue.main.async {
            self.didEnterGeofence = false
            self.didExitGeofence = true
        }
    }

    // 오류 처리
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 오류: \(error.localizedDescription)")
    }
}

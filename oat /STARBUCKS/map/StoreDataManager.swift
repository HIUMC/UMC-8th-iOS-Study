//
//  StoreDataManager.swift
//  STARBUCKS
//
//  Created by 신민정 on 4/28/25.
//

import Foundation
import CoreLocation

enum StoreTab {
    case nearby
    case frequent
}



class StoreDataManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    //StoreDataManager: 매장 데이터 + 사용자 위치를 다루는 클래스
    //ObservableObject: SwiftUI에서 뷰와 데이터 상태 연동
    //CLLocationManagerDelegate : 위치 업데이트 콜백 받기

    @Published var stores: [Store] = [] // 매장 리스트 저장
    @Published var displayedStores: [Store] = []
    //뷰에서 이 stores 가 바뀌면 자동으로 화면 갱신이 됨
    @Published var userLocation: CLLocation?
    //사용자 현재 위치 정보 저장
    private var locationManager = CLLocationManager()
    //iOS 시스템에서 위치를 추적하는 클래스
    
    func updateDisplayedStores(center: CLLocationCoordinate2D) {
        let base = CLLocation(latitude: center.latitude, longitude: center.longitude)
        displayedStores = stores.filter {
            let loc = CLLocation(latitude: $0.latitude, longitude: $0.longitude)
            return base.distance(from: loc) / 1000 <= 10
        }
    }



    
    override init() {
        super.init()
        locationManager.delegate = self //위치가 바뀔 때 알림을 받을 대상을 자신(self)로 지정
        locationManager.requestWhenInUseAuthorization() //사용자에게 위치 정보 접근을 허용(사용중에)
        locationManager.startUpdatingLocation() //위치 업데이트
        
        loadStores()
        //GeoJSON 파일을 불러와 매장 데이터를 파싱하는 함수 호출
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.first
        //위치가 없데이트 되면 가장 첫 위치를(locations.first) userLocation에 저장/ 이후 거리계산, 매장 정렬에 사용됨
    }
    func distanceFromUser(to store: Store) -> Double? {
        guard let userLocation = userLocation else {
            return nil
        } //사용자 위치가 없는 경우는 nil 반환
        
        let storeLocation = CLLocation(latitude: store.latitude, longitude: store.longitude)
        let distanceInMeters = userLocation.distance(from: storeLocation)
        return distanceInMeters / 1000 // meter → km
        //매장 위치를 CLLoction으로 변환
        //distance(from:) 사용해서 사용자와의 거리(m 단위) 계산
    }
    
    //GeoJSON 파싱 함수
    func loadStores() { //앱 시작시 실행되는 매장 불러오기 함수
        guard let url = Bundle.main.url(forResource: "스타벅스_2025 데이터", withExtension: "geojson") else {
            //프로젝트에 있는 "스타벅스" 파일을 찾음
            
            print("GeoJSON 파일 없음")
            //없으면 오류 출력
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            //파일을 불러와서 Data 타입으로 읽는다
            let decodedData = try JSONDecoder().decode(FeatureCollection.self, from: data)
            //FeatureCollection 이라는 구조체로 디코딩
            
            //GeoJSON 내부의 매장 목록을 순회하며 Store 타입으로 변환
            let loadedStores: [Store] = decodedData.features.map { feature in
                
                let rawCategory = feature.properties.category
                //문자열로 되어 있는 매장 카테고리 추출.
                
                let category: StoreCategory
                if rawCategory == "리저브 매장" {
                    category = .reserve
                } else if rawCategory == "DT 매장" {
                    category = .driveThru
                } else {
                    category = .normal
                }
                //문자열을 내가 정의한 enum(StoreCategory) 타입으로 변환
                
                
                return Store(
                    name: feature.properties.name,
                    address: feature.properties.address,
                    latitude: feature.properties.latitude,
                    longitude: feature.properties.longitude,
                    category: category
                )
                //최종적으로 Store 배열로 가공
            }
                
                
                if let userLocation = userLocation {
                    self.stores = loadedStores.sorted {
                        let loc1 = CLLocation(latitude: $0.latitude, longitude: $0.longitude)
                        let loc2 = CLLocation(latitude: $1.latitude, longitude: $1.longitude)
                        return userLocation.distance(from: loc1) < userLocation.distance(from: loc2)
                    }
                    //사용자 위치가 있다면, 가까운 순으로 매장을 정렬한다
                } else {
                    self.stores = loadedStores
                }
                //위치가 없으면 정렬 없이 그대로 저장
                
            } catch {
                print("GeoJSON 실패: \(error.localizedDescription)")
            } //디코딩 오류가 발생하면 콘솔에 에러 메시지 출력
        }
        
    }


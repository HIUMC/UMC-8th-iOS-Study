//
//  DirectionsSearchViewModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/19/25.
//
//OSRM 경로 검색 요청을 담당하는 뷰모델
//경로찾기 

import Foundation
import CoreLocation
import Moya


class DirectionsSearchViewModel: ObservableObject {
    private let provider = MoyaProvider<OSRMRouter>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    @Published var isLoading: Bool = false
    @Published var routeCoordinates: [CLLocationCoordinate2D] = []
    @Published var routeGeoJSON: GeoJSONRoute?
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    func searchRoute(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) {
        print("from: \(from.latitude), \(from.longitude)")
        print("to: \(to.latitude), \(to.longitude)")
        
        //경도 위도 순임 ! 
        let start = "\(from.longitude),\(from.latitude)"
        let end = "\(to.longitude),\(to.latitude)"
        
        print("OSRM 요청 URL: /route/v1/foot/\(start);\(end)")
        
        provider.request(.route(start: start, end: end)) { [weak self] result in
            print("Moya 요청 전송됨")
            
            switch result {
            case .success(let response):
                print("응답 수신 완료 (status code: \(response.statusCode))")
                
                do {
                    let decoded = try JSONDecoder().decode(GeoJSONRoute.self, from: response.data)
                    let coordinates = decoded.routes.first?.geometry.coordinates.map {
                        CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0])
                    } ?? []
                    
                    
                    DispatchQueue.main.async {
                        self?.routeGeoJSON = decoded
                        self?.routeCoordinates = coordinates
                    }
                    
                } catch {
                    print("디코딩 에러: \(error)")
                    if let responseString = String(data: response.data, encoding: .utf8) {
                        print("응답 원문:\n\(responseString)")
                    }
                    
                    DispatchQueue.main.async {
                        self?.alertMessage = "경로 응답 디코딩 실패"
                        self?.showAlert = true
                    }
                }
                
            case .failure(let error):
                print("요청 실패: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.alertMessage = "경로 요청 실패: \(error.localizedDescription)"
                    self?.showAlert = true
                }
            }
        }
    }
}

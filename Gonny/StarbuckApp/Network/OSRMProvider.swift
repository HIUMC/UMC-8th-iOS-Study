//
//  OSRMProvider.swift
//  StarbuckApp
//
//  Created by 박병선 on 5/27/25.
//
//플러그인에 로그옵션 넣어서 디버깅하깅
import CoreLocation
import Moya

let provider = MoyaProvider<OSRMAPI>()

func fetchRoute(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D) {
    provider.request(.route(start: start, end: end)) { result in
        switch result {
        case .success(let response):
            print("응답 데이터: \(response.data)")
            // JSONDecoder로 디코딩해서 지도에 선 그리기
        case .failure(let error):
            print("요청 실패: \(error)")
        }
    }
}

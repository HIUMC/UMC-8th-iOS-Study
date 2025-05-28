//
//  PlaceSearchViewModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/19/25.
//
// 카카오 키워드 검색 결과 관리 
//출발지 키워드
//돋보기 버튼 누르면 호출되는 함수 요거

import Foundation
import Moya
import CoreLocation

class PlaceSearchViewModel: ObservableObject {
    @Published var results: [Place] = []
    @Published var selectedPlace: Place?
    @Published var departureCoordinate: CLLocationCoordinate2D?
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    
    
    private let provider = MoyaProvider<KakaoRouter>()
    func search(keyword: String) {
        provider.request(.keywordSearch(query: keyword)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    if let responseString = String(data: response.data, encoding: .utf8) {
                        print("Kakao 응답 원문:\n\(responseString)")
                    }
                    
                    let decoded = try JSONDecoder().decode(KakaoPlaceResponse.self, from: response.data)
                    DispatchQueue.main.async {
                        self?.results = decoded.documents
                    }
                } catch {
                    print("유저 데이터 디코더 오류", error)
                }
                
            case .failure(let error):
                print("Kakao 장소 검색 실패", error)
            }
        }
    }
}

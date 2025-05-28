//
//  FindPathViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 5/22/25.
//
import Foundation
import Combine
import Moya
import CoreLocation

//사용자가 입력한 검색어(SearchText)를 기반으로 kakaoAPI를 통해 장소 리스트를 불러오는 뷰모델
//사용자가 TextField에 중앙대 입력 -> 0.3초 기다린 후 kakaoAPI 호출 -> 관련 장소 리스트 반환 -> list로 표시
class PlaceSearchViewModel: ObservableObject {
    @Published var searchText: String = ""//사용자가 입력한 장소 검색어("홍익대" 등)
    @Published var searchResults: [Place] = []//카카오API로 받은 장소 리스트
    @Published var selectedPlace: Place? = nil//유저가 선택한 장소 하나("홍익대학교 서울캠퍼스")
    @Published var isShowingNoResultAlert: Bool = false//이상한 거 입력했을 때 경고문
    private var locationManager = LocationManager.shared

    private var cancellables = Set<AnyCancellable>()
    private let provider = MoyaProvider<KakaoAPI>()

    init() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self = self else {return}
                guard !text.isEmpty else {
                    self.searchResults = []
                    return
                }
                
                self.searchKeyword(query: text, coordinate: locationManager.currentLocation?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
            }
            .store(in: &cancellables)
    }
    
    
 func searchKeyword(query: String, coordinate: CLLocationCoordinate2D) {
        self.provider.request(.keywordSearch(query: query, coordinate: coordinate)){ result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(KakaoSearchResponse.self, from: response.data)
                    DispatchQueue.main.async {
                        self.searchResults = decoded.documents
                        //검색 결과가 없을 때 Alert띄움
                        if self.searchResults.isEmpty {
                            self.isShowingNoResultAlert = true
                        }
                    }
                } catch {
                    print("디코딩 실패: \(error)")
                    print("응답: ", String(data: response.data, encoding: .utf8) ?? "없음")
                }
            case .failure(let error):
                print("요청 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func selectPlace(_ place: Place) {
            self.selectedPlace = place
            self.searchText = place.place_name
            self.searchResults = [] // 리스트 숨기기
        }
    
    func
    
}

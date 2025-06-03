//
//  FindingWayView.swift
//  Starbucks
//
//  Created by 김영택 on 2025/5/29.
//

import SwiftUI
import Combine
import CoreLocation

struct FindingWayView: View {
    @StateObject private var locationManager = LocationManager.shared
    @State private var searchText: String = ""
    @State private var searchResults: [Place] = []
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                TextField("주소 입력 또는 장소명 검색", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.trailing, 8)
                
                Button(action: {
                    locationManager.requestLocation()
                    searchText = locationManager.currentAddress // 버튼을 눌러야만 반영됨
                }) {
                    Image(systemName: "location.fill")
                        .foregroundColor(.blue)
                }
                .padding(.trailing)
            }
            .padding()
            
            Button("검색") {
                searchPlace(keyword: searchText)
            }
            .padding(.horizontal)
            
            List(searchResults) { place in
                VStack(alignment: .leading) {
                    Text(place.place_name)
                        .font(.headline)
                    if let road = place.road_address_name {
                        Text(road)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .navigationTitle("길 찾기")
    }
    
    func searchPlace(keyword: String) {
        guard let encoded = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://dapi.kakao.com/v2/local/search/keyword.json?query=\(encoded)") else {
            return
        }

        var request = URLRequest(url: url)
        request.addValue("KakaoAK [f83a219d60e436e0676cf2836ea817d9]", forHTTPHeaderField: "Authorization") // ← 여기에 본인의 REST API 키 넣기

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: KakaoPlaceSearchResponse.self, decoder: JSONDecoder())
            .replaceError(with: KakaoPlaceSearchResponse(meta: Meta(total_count: 0, pageable_count: 0, is_end: true), documents: []))
            .receive(on: DispatchQueue.main)
            .sink { response in
                self.searchResults = response.documents
            }
            .store(in: &cancellables)
    }
}

#Preview {
    FindingWayView()
}

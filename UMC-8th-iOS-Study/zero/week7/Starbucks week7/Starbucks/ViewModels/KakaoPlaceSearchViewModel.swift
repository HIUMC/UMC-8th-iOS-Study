//
//  KakaoPlaceSearchViewModel.swift
//  Starbucks
//
//  Created by 김영택 on 5/29/25.
//

import Foundation
import Combine

class KakaoPlaceSearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var places: [Place] = []
    @Published var selectedPlace: Place?

    private var cancellables = Set<AnyCancellable>()

    private let kakaoApiKey = "KAKAO_REST_API_KEY_여기에_넣기"

    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self = self else { return }
                Task {
                    await self.searchPlaces(query: text)
                }
            }
            .store(in: &cancellables)
    }

    @MainActor
    func searchPlaces(query: String) async {
        guard !query.isEmpty else {
            places = []
            return
        }

        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlStr = "https://dapi.kakao.com/v2/local/search/keyword.json?query=\(encodedQuery)&size=15"
        guard let url = URL(string: urlStr) else { return }

        var request = URLRequest(url: url)
        request.setValue("KakaoAK \(kakaoApiKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(KakaoPlaceSearchResponse.self, from: data)
            places = response.documents
        } catch {
            print("검색 오류:", error.localizedDescription)
            places = []
        }
    }
}

//
//  GoogleAPIService.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/23/25.
//

import Foundation

final class GoogleAPIService {
    static let shared = GoogleAPIService()

    private init() {}

    func fetchPhotoReference(for storeName: String, completion: @escaping (String?) -> Void) {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_API_KEY") as? String ?? ""
        let query = storeName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(query)&key=\(apiKey)"

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("❌ 네트워크 에러:", error.localizedDescription)
                completion(nil)
                return
            }

            guard let data = data else {
                print("❌ 데이터 없음")
                completion(nil)
                return
            }

            print("📦 응답 데이터:", String(data: data, encoding: .utf8) ?? "디코딩 실패")

            guard let decoded = try? JSONDecoder().decode(GooglePlacesResponse.self, from: data),
                  let reference = decoded.results.first?.photos?.first?.photoReference else {
                print("❌ 디코딩 실패")
                completion(nil)
                return
            }

            completion(reference)
        }.resume()
    }
}

import Foundation
import CoreLocation


@Observable
class JSONParsingViewModel {
    var stores: [StoreFeature] = []

    func loadStores(completion: @escaping (Result<[StoreFeature], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            print("❌ json 파일 없음")
            completion(.failure(NSError(domain: "파일을 찾을 수 없습니다", code: 404, userInfo: nil)))
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(StoreFeatureCollection.self, from: data)
            self.stores = decoded.features
            print("✅ 디코딩 성공")
            completion(.success(decoded.features))
        } catch {
            print("❌ 디코딩 실패: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
}

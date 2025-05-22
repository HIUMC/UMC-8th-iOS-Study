import Foundation

@Observable
class JSONParsingViewModel {
    var starbuckStore: StoreFeatureCollection?
    
    func loadStarbucks(completion: @escaping (Result<StoreFeatureCollection, Error>) -> Void) {
        // GeoJSON 파일명과 일치해야한다.
        guard let url = Bundle.main.url(forResource: "starbuckStore", withExtension: "geojson") else {
            print("geojson 파일 없음")
            completion(.failure(NSError(domain: "geojson 파일 못 찾았는뎅 ㅋ", code: 404, userInfo: nil)))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            // MapModel로 디코딩할거야
            let decoded = try JSONDecoder().decode(StoreFeatureCollection.self, from: data)
            self.starbuckStore = decoded
            print("디코딩 성공!")
            completion(.success(decoded))
        } catch {
            print("디코딩 실패: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
}

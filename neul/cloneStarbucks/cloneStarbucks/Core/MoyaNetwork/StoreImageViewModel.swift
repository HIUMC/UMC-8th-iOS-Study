//
//  StoreImageViewModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 5/26/25.
//

import SwiftUI
import Observation
import Moya

class StoreImageViewModel: ObservableObject {
    let provider: MoyaProvider<GetStoreImage>
    
    init(provider: MoyaProvider<GetStoreImage> = APIManager.shared.createProvider(for: GetStoreImage.self)) {
        self.provider = provider
    }
    
    
    func getStoreInfo(query: String) async throws -> String? {
        do {
            let response = try await provider.requestAsync(.getStoreInfo(query: query))
            let placeResponse = try JSONDecoder().decode(PlaceResponseModel.self, from: response.data)
            print("text로 가게 정보 가져오기: \(placeResponse)")
            guard let imageData = placeResponse.results[0].photos?[0].photoReference else { return nil }
            return imageData
        } catch {
            print("가게 정보 받아오기 실패", error)
            return nil
        }
    }
    
}


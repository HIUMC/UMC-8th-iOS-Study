//
//  RouteViewModel.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/22/25.
//

import Foundation
import Moya

class RouteViewModel: ObservableObject {
    @Published var distance: Double = 0
    @Published var duration: Double = 0
    
    let provider: MoyaProvider<OSRMRouter>
    
    init(provider: MoyaProvider<OSRMRouter> = APIManager.shared.createProvider(for: OSRMRouter.self)) {
        self.provider = provider
    }
    
    func fetchRoute(start: (Double, Double), end: (Double, Double)) {
        provider.request(.route(start: start, end: end)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(RouteModel.self, from: response.data)
                    if let route = decoded.routes.first {
                        DispatchQueue.main.async {
                            self.distance = route.distance
                            self.duration = route.duration
                        }
                    }
                } catch {
                    print("❌ 디코딩 에러:", error)
                }
            case .failure(let error):
                print("❌ 요청 실패:", error.localizedDescription)
            }
        }
    }

}

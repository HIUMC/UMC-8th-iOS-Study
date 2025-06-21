//
//  GETMethod.swift
//  MoyaTest
//
//  Created by 박병선 on 5/27/25.
//
import Foundation
import Moya

@Observable
class ContentsViewModel {
    var userData: UserData?
    let provider: MoyaProvider<UserRotuer>
    
    init() {
        let logger = NetworkLoggerPlugin(configuration: .init(logOptions: [.verbose]))
        self.provider = MoyaProvider<UserRotuer>(plugins: [logger])
    }
    
    func getUserData(name: String) {
        provider.request(.getPerson(name: name), completion: { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(UserData.self, from: response.data)
                    self?.userData = decodedData
                } catch {
                    print("유저 데이터 디코더 오류", error)
                }
            case .failure(let error):
                                        print("error", error)
            }
        })
    }
}


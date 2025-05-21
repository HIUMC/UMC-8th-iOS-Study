//
//  ContentsViewModel.swift
//  week7Practice
//
//  Created by tokkislove on 5/19/25.
//

import Foundation
import Moya
    
    


@Observable
class ContentsViewModel {
    var userData: UserData?
    let provider: MoyaProvider<UserRouter>
    
    init() {
        let logger = NetworkLoggerPlugin(configuration: .init(logOptions: [.verbose]))
        self.provider = MoyaProvider<UserRouter>(plugins: [logger])
    }
    
    // 여기서만 일부러 do catch 문을 사용한 것임!
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
    
    func createUser(_ userData: UserData) {
        provider.request(.postPerson(userData: userData)) { result in
            switch result {
            case .success(let response):
                print("POST 성공: \(response.statusCode)")
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    func updateUserPatch(_ patchData: UserPatchRequest) {
        provider.request(.patchPerson(patchData: patchData)) { result in
            switch result {
            case .success(let response):
                print("PATCH 성공: \(response.statusCode)")
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    func updateUserPut(_ userData: UserData) {
        provider.request(.putPerson(userData: userData)) { result in
            switch result {
            case .success(let response):
                print("PUT 성공: \(response.statusCode)")
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    func deleteUser(name: String) {
        provider.request(.deletePerson(name: name)) { result in
            switch result {
            case .success(let response):
                print("DELETE 성공: \(response.statusCode)")
            case .failure(let error):
            print("error", error)
            }
        }
    }
    
    
    // async combineMoya 없이 구현
    func getUser() async {
        do {
            let response = try await provider.requestAsync(.getPerson(name: "제옹"))
            let user = try JSONDecoder().decode(UserData.self, from: response.data)
            print("유저", user)
        } catch {
            print("요청 또는 디코딩 실패:", error.localizedDescription)
        }
    }
}




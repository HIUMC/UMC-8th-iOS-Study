//
//  ServiceManagerGlobal.swift
//  UMC-iOS-WorkBook-6-Alamofire
//
//  Created by 곽은채 on 5/11/25.
//

import Foundation
import Alamofire

// global은 공유된 전역 시스템 큐 -> 여러 작업이 공유되어 뒤섞이면서 안정적이지 못함
// => 큐를 분리 == CustomQueue
class ServiceManagerGlobal {
    
    let urlString: String = "http://localhost:8080/person"
    
    // MARK: - GET 요청
    
    func getUser(name: String) {
        let parameter: [String: String] = [
            "name": name
        ]
        
        AF.request(urlString, method: .get, parameters: parameter, encoding: URLEncoding.default)
            .validate()
            .responseDecodable(of: UserDTO.self, queue: .global(), completionHandler: { response in
                switch response.result {
                case .success(let user):
                    print("GET 성공:", user)
                case .failure(let error):
                    print("GET 에러:", error)
                }
            })
    }
    
    // MARK: - POST 요청
    
    func postUser(user: UserDTO) {
        AF.request(urlString, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: String.self, queue: .global(), completionHandler: { response in
                switch response.result {
                case .success(let success):
                    print("POST 성공:", success)
                case .failure(let error):
                    print("POST 에러:", error.localizedDescription)
                }
            })
    }
    
    // MARK: - PUT 요청
    
    func putUser(user: UserDTO) {
        AF.request(urlString, method: .put, parameters: user, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: String.self, queue: .global(), completionHandler: { response in
                switch response.result {
                case .success(let user):
                    print("PUT 성공: \(user)")
                case .failure(let error):
                    print("PUT 실패: \(error.localizedDescription)")
                }
            })
    }
    
    // MARK: - PATCH 요청
    
    func patchUser(name: String) {
        
        let parameter: [String: String] = [
            "name": name
        ]
        
        AF.request(urlString, method: .patch, parameters: parameter, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: String.self, queue: .global(), completionHandler: { response in
                switch response.result {
                case .success(let user):
                    print("PATCH 성공: \(user)")
                case .failure(let error):
                    print("PATCH 실패: \(error.localizedDescription)")
                }
            })
    }
    
    // MARK: - DELETE
    
    func deleteUser(name: String) {
        
        let parameter: [String: String] = [
            "name": name
        ]
        
        AF.request(urlString, method: .delete, parameters: parameter, encoding: URLEncoding.default)
            .validate()
            .responseDecodable(of: String.self, queue: .global(), completionHandler: { response in
                switch response.result {
                case .success(let user):
                    print("PUT 성공: \(user)")
                case .failure(let error):
                    print("PUT 실패: \(error.localizedDescription)")
                }
            })
    }
    
    
}

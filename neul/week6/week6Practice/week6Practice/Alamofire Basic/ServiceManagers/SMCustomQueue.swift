//
//  SMCustomQueue.swift
//  week6Practice
//
//  Created by tokkislove on 5/10/25.
//

import Foundation
import Alamofire

// networkQueue를 직접 만들고 관리하기 때문에 이 큐를 사용하는 모든 네트워크 응답은 순차적으로 실행
// 디코딩 / 처리 순서를 명확하게 보장할 수 있어, 복잡한 연산이 꼬이는 문제를 줄일 수 있음 -> 동시성 제어가 훨씬 더 좋아짐
// 메인 스레드를 막지 않으므로, 앱 UI에 끊김이 없으며 QOS 설정으로 CPU와 리소스를 높은 우선순위로 할당받을 수 있음


class ServiceManagerCQ {
    
    let urlString: String = "http://localhost:8080/person"
    private let networkQueue = DispatchQueue(label: "com.testAlamofire.network", qos: .userInitiated)
    
    // MARK: - GET 요청
    
    func getUser(name: String) {
        let parameter: [String: String] = [
            "name": name
        ]
        
        AF.request(urlString, method: .get, parameters: parameter, encoding: URLEncoding.default)
            .validate()
            .responseDecodable(of: UserDTO.self, queue: networkQueue, completionHandler: { response in
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
            .responseDecodable(of: String.self, queue: networkQueue, completionHandler: { response in
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
            .responseDecodable(of: String.self, queue: networkQueue, completionHandler: { response in
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
            .responseDecodable(of: String.self, queue: networkQueue, completionHandler: { response in
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
            .responseDecodable(of: String.self, queue: networkQueue, completionHandler: { response in
                switch response.result {
                case .success(let user):
                    print("PUT 성공: \(user)")
                case .failure(let error):
                    print("PUT 실패: \(error.localizedDescription)")
                }
            })
    }
    
    
}

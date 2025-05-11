//
//  SMGlobalQueue.swift
//  week6Practice
//
//  Created by tokkislove on 5/10/25.
//

import Foundation
import Alamofire

//responseDecodable, responseData, responseJSON 같은 응답 핸들러는 기본적으로 메인 스레드에서 콜백을 실행
//네트워크 응답을 받은 다음 UI 업데이트를 해야 하기 때문
// global()을 사용 -> 공유된 전역 시스템 큐 -> 여러 작업이 공유되어 뒤섞일 수 있는 문제 -> 안정적이지가 못함! 엄청!

class ServiceManagerGQ {
    
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

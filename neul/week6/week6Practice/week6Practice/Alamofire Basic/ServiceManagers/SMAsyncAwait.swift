//
//  SMAsyncAwait.swift
//  week6Practice
//
//  Created by tokkislove on 5/10/25.
//

import Foundation
import Alamofire

// Async/Await은...
// 1. 비동기 코드를 마치 순차적(동기적) 코드처럼 쓸 수 있도록 한다
// 2. 들여쓰기 없이 위에서 아래로 자연스럽게 읽히는 흐름으로 관리한다.
// completionHandler(콜백 안에 콜백 안에 콜백..) 를 사용하던 방식을 버리고 가독성 증가 (순차 코드처럼 작동ㅎㅎ, 직관적, 선형적 코드 흐름)
// 여러 에러 종류를 하나의 catch로 받아서 관리할 수 있음
// 스레드를 점유하고, 필요 없으면 스레드를 시스템에 돌려주는 식으로 동작. ((GCD 보다 더 똑똑하게 동작)) Swift가 알아서 스레드 관리.


final class ServiceManagerAA {
    
    static let shared = ServiceManagerAA()
        
    private let session: Session
    
    private let urlString: String = "\(Config.baseURL)/person"
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        
        self.session = Session(configuration: configuration)
    }
    
    // MARK: - GET 요청
    func getUser(name: String) async {
        let parameters: [String: String] = [
            "name": name
        ]
        
        do {
            let user = try await AF.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.default)
                .serializingDecodable(UserDTO.self)
                .value
            print("GET 성공:", user)
        } catch {
            print("GET 실패:", error.localizedDescription)
        }
    }
    
    // MARK: - POST 요청
    func postUser(user: UserDTO) async {
        do {
            let response = try await AF.request(urlString, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
                .serializingString()
                .value
            print("POST 성공:", response)
        } catch {
            print("POST 실패:", error.localizedDescription)
        }
    }
    
    // MARK: - PUT 요청
    func putUser(user: UserDTO) async {
        do {
            let response = try await AF.request(urlString, method: .put, parameters: user, encoder: JSONParameterEncoder.default)
                .serializingString()
                .value
            print("PUT 성공:", response)
        } catch {
            print("PUT 실패:", error.localizedDescription)
        }
    }
    
    // MARK: - PATCH 요청
    func patchUser(name: String) async {
        let parameters: [String: String] = [
            "name": name
        ]
        
        do {
            let response = try await AF.request(urlString, method: .patch, parameters: parameters, encoding: JSONEncoding.default)
                .serializingString()
                .value
            print("PATCH 성공:", response)
        } catch {
            print("PATCH 실패:", error.localizedDescription)
        }
    }
    
    // MARK: - DELETE 요청
    func deleteUser(name: String) async {
        let parameters: [String: String] = [
            "name": name
        ]
        
        do {
            let response = try await AF.request(urlString, method: .delete, parameters: parameters, encoding: URLEncoding.default)
                .serializingString()
                .value
            print("DELETE 성공:", response)
        } catch {
            print("DELETE 실패:", error.localizedDescription)
        }
    }
}

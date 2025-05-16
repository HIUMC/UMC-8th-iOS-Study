//
//  ServiceManager.swift
//  UMC-iOS-WorkBook-6-Alamofire
//
//  Created by 곽은채 on 5/11/25.
//

import Foundation
import Alamofire

// async/await를 적용한 최종 버전
// 에러 핸들링이 더 깔끔해짐(completionHandler, switch case문 없어짐), 여러 에러 종류를 catch 하나로 받음
// 스레드는 알아서 관리: 필요할 때만 스레드를 점유하고, 필요 없으면 스레드를 시스템에 돌려주는 식으로 동작
final class ServiceManager {
    
    static let shared = ServiceManager()
    
    private let session: Session
    private let urlString: String = "\(Config.baseURL)/person"
    // API_URL 적용 전 코드
    // private let urlString: String = "http://localhost:8080/person"
    
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
            let user = try await session.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.default)
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
            let response = try await session.request(urlString, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
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
            let response = try await session.request(urlString, method: .put, parameters: user, encoder: JSONParameterEncoder.default)
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
            let response = try await session.request(urlString, method: .patch, parameters: parameters, encoding: JSONEncoding.default)
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
            let response = try await session.request(urlString, method: .delete, parameters: parameters, encoding: URLEncoding.default)
                .serializingString()
                .value
            print("DELETE 성공:", response)
        } catch {
            print("DELETE 실패:", error.localizedDescription)
        }
    }
}


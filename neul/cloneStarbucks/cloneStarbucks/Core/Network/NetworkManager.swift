//
//  NetworkManager.swift
//  cloneStarbucks
//
//  Created by tokkislove on 5/12/25.
//

import Foundation
import Alamofire
import SwiftUI

// Async/Await은...
// 1. 비동기 코드를 마치 순차적(동기적) 코드처럼 쓸 수 있도록 한다
// 2. 들여쓰기 없이 위에서 아래로 자연스럽게 읽히는 흐름으로 관리한다.
// completionHandler(콜백 안에 콜백 안에 콜백..) 를 사용하던 방식을 버리고 가독성 증가 (순차 코드처럼 작동ㅎㅎ, 직관적, 선형적 코드 흐름)
// 여러 에러 종류를 하나의 catch로 받아서 관리할 수 있음
// 스레드를 점유하고, 필요 없으면 스레드를 시스템에 돌려주는 식으로 동작. ((GCD 보다 더 똑똑하게 동작)) Swift가 알아서 스레드 관리.


final class NetworkManager {
    
    static let shared = NetworkManager()
        
    private let session: Session
    
   // let redirectURI = "kakaob0e106cc098023e4d9bd784349293d69://oauth"
    
    private let urlString: String = "https://kauth.kakao.com/oauth/authorize?client_id=\(Config.restApiKey)&redirect_uri=http://localhost:8080/oauth2/redirect/kakao&response_type=code"
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        
        self.session = Session(configuration: configuration)
    }
    
    // MARK: - GET 요청
    func kakaoLogin() async -> URL? {
        
        do {
            /*let response = try await AF.request(urlString, method: .get, encoding: URLEncoding.default)
                .serializingString()
                .value
            print("GET 성공:", response)*/
            let url = URL(string: urlString)
            return url
        }
        /*catch {
            print("GET 실패:", error.localizedDescription)
            return nil
        }*/
    }
    /*
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
    }*/
}

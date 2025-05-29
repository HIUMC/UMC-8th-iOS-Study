//
//  MoyaProvider.swift
//  7th_Example
//
//  Created by 박병선 on 5/27/25.
//
//MoyaProvider은 TargetType을 기반으로 API네트워크 요청을 보내는 객체
import Moya
import Foundation


//MoyaProvider
let provider = MoyaProvider<HelloAPI>()

provider.request(.hello) { result in
    switch result {
    case .success(let response):
        do {
            let json = try JSONSerialization.jsonObject(with: response.data, options: [])
            print("응답 성공:", json)
        } catch {
            print("파싱 실패:", error)
        }
        
    case .failure(let error):
        print("요청 실패:", error)
    }
}

//Codable을 활용한 응답데이터를 모델로 디코딩

/*
 let provider = MoyaProvider<HelloAPI>()

 provider.request(.hello) { result in
     switch result {
     case .success(let response):
         do {
                       let decoded = try JSONDecoder().decode(모델데이터.self, from: response.data)
             print("응답 성공:", json)
         } catch {
             print("파싱 실패:", error)
         }
         
     case .failure(let error):
         print("요청 실패:", error)
     }
 }
 */

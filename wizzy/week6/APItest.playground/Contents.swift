/* POST Method
 import SwiftUI
 
 let url = URL(string: "http://localhost:8080/person")!
 var request = URLRequest(url: url)
 request.httpMethod = "POST"
 
 let parameters: [String: Any] = [
 "name": "제옹",
 "age": 29,
 "address": "포항시 대잠동",
 "height": 178
 ]
 
 request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
 request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 
 let task = URLSession.shared.dataTask(with: request) { data, response, error in
 if let error = error {
 print("에러: \(error)")
 return
 }
 
 if let httpResponse = response as? HTTPURLResponse {
 print("상태 코드: \(httpResponse.statusCode)")
 }
 
 if let data = data {
 let responseString = String(data: data, encoding: .utf8)
 print("응답: \(responseString!)")
 }
 }
 
 task.resume()
 */




/* GET Method
 import SwiftUI

 var urlComponents = URLComponents(string: "http://localhost:8080/person")!
 urlComponents.queryItems = [
     URLQueryItem(name: "name", value: "제옹")
 ]

 let url = urlComponents.url!

 let task = URLSession.shared.dataTask(with: url) { data, response, error in
     if let error = error {
         print("에러: \(error)")
         return
     }

     if let httpResponse = response as? HTTPURLResponse {
         print("상태 코드: \(httpResponse.statusCode)")
     }

     if let data = data {
         let responseString = String(data: data, encoding: .utf8)
         print("응답: \(responseString!)")
     }
 }
 task.resume()
 
 */




/* PATCH Method
 import SwiftUI

 let url = URL(string: "http://localhost:8080/person")!
 var request = URLRequest(url: url)
 request.httpMethod = "PATCH"

 let parameters: [String: Any] = [
     "name": "Je-Ong",
 ]
 request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
 request.setValue("application/json", forHTTPHeaderField: "Content-Type")

 let task = URLSession.shared.dataTask(with: request) { data, response, error in
     if let error = error {
         print("에러: \(error)")
         return
     }

     if let httpResponse = response as? HTTPURLResponse {
         print("상태 코드: \(httpResponse.statusCode)")
     }

     if let data = data {
         let responseString = String(data: data, encoding: .utf8)
         print("응답: \(responseString!)")
     }
 }
 task.resume()
 */





/* PUT Method
 import SwiftUI

 let url = URL(string: "http://localhost:8080/person")!
 var request = URLRequest(url: url)
 request.httpMethod = "PATCH"

 // 요청 본문에 전송할 데이터
 let parameters: [String: Any] = [
     "name": "Je-Ong",
 ]
 request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
 request.setValue("application/json", forHTTPHeaderField: "Content-Type")

 let task = URLSession.shared.dataTask(with: request) { data, response, error in
     if let error = error {
         print("에러: \(error)")
         return
     }

     if let httpResponse = response as? HTTPURLResponse {
         print("상태 코드: \(httpResponse.statusCode)")
     }

     if let data = data {
         let responseString = String(data: data, encoding: .utf8)
         print("응답: \(responseString!)")
     }
 }
 task.resume()
 */




/* DELETE Method
 import SwiftUI

 var urlComponents = URLComponents(string: "http://localhost:8080/person")!
 urlComponents.queryItems = [
     URLQueryItem(name: "name", value: "제옹")
 ]

 let url = urlComponents.url!
 var request = URLRequest(url: url)
 request.httpMethod = "DELETE"

 let task = URLSession.shared.dataTask(with: request) { data, response, error in
     if let error = error {
         print("에러: \(error)")
         return
     }

     if let httpResponse = response as? HTTPURLResponse {
         print("Status Code: \(httpResponse.statusCode)")
     }

     if let data = data {
         let responseString = String(data: data, encoding: .utf8)
         print("Response Data: \(responseString!)")
     }
 }
 task.resume()
 */




/* Actor를 이용한 GET Method 예시 코드
 actor NetworkManager {
     func getUserData() async throws -> String {
         var urlComponents = URLComponents(string: "http://localhost:8080/person")!
         urlComponents.queryItems = [
             URLQueryItem(name: "name", value: "제옹")
         ]
         
         guard let url = urlComponents.url else {
             throw URLError(.badURL)
         }
         
         let (data, response) = try await URLSession.shared.data(from: url)
         
         guard let httpResponse = response as? HTTPURLResponse,
               (200...299).contains(httpResponse.statusCode) else {
             throw URLError(.badServerResponse)
         }
         
         guard let responseString = String(data: data, encoding: .utf8) else {
             throw URLError(.cannotDecodeContentData)
         }
         
         return responseString
     }
 }

 let networkManager = NetworkManager()

 Task {
     do {
         let result = try await networkManager.getUserData()
         print("응답 데이터:", result)
     } catch {
         print("네트워크 에러", error)
     }
 }

 */



/* Post - Actor
import SwiftUI

actor PersonAPI {
    private let url = URL(string: "http://localhost:8080/person")!
    
    func createPerson(name: String, age: Int, address: String, height: Int) async throws -> String {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters: [String: Any] = [
            "name": name,
            "age": age,
            "address": address,
            "height": height
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        print("상태 코드: \(httpResponse.statusCode)")
        
        if let responseString = String(data: data, encoding: .utf8) {
            return responseString
        } else {
            return "응답 디코딩 실패"
        }
    }
}
*/

import Foundation

actor PersonAPI {
    private let baseURL = "http://localhost:8080/person"

    func deletePerson(named name: String) async throws -> String {
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "name", value: name)
        ]
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        print("🗑️ DELETE 상태 코드: \(httpResponse.statusCode)")
        
        if let responseString = String(data: data, encoding: .utf8) {
            return responseString
        } else {
            return "응답 디코딩 실패"
        }
    }
}

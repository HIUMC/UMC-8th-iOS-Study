//import SwiftUI
//
//let url = URL(string: "http://localhost:8080/person")!
//var request = URLRequest(url: url)
//request.httpMethod = "POST"
//
//let parameters: [String: Any] = [
//      "name": "제옹",
//      "age": 29,
//      "address": "포항시 대잠동",
//      "height": 178
//]
//
//request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//    
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//    
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString!)")
//    }
//}
//
//task.resume()

//import SwiftUI
//
//var urlComponents = URLComponents(string: "http://localhost:8080/person")!
//urlComponents.queryItems = [
//    URLQueryItem(name: "name", value: "제옹")
//]
//
//let url = urlComponents.url!
//
//let task = URLSession.shared.dataTask(with: url) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString!)")
//    }
//}
//task.resume()
//
//

//import SwiftUI
//
//let url = URL(string: "http://localhost:8080/person")!
//var request = URLRequest(url: url)
//request.httpMethod = "PATCH"
//
//let parameters: [String: Any] = [
//    "name": "Je-Ong",
//]
//request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString!)")
//    }
//}
//task.resume()


//import SwiftUI
//
//let url = URL(string: "http://localhost:8080/person")!
//var request = URLRequest(url: url)
//request.httpMethod = "PUT"
//
//// 요청 본문에 전송할 데이터
//let parameters: [String: Any] = [
//    "name": "Je-Ong",
//]
//request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//
//    if let httpResponse = response as? HTTPURLResponse {
//        print("상태 코드: \(httpResponse.statusCode)")
//    }
//
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("응답: \(responseString!)")
//    }
//}
//task.resume()
//task.resume()


//import SwiftUI
//
//var urlComponents = URLComponents(string: "http://localhost:8080/person")!
//urlComponents.queryItems = [
//    URLQueryItem(name: "name", value: "제옹")
//]
//
//let url = urlComponents.url!
//var request = URLRequest(url: url)
//request.httpMethod = "DELETE"
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    if let error = error {
//        print("에러: \(error)")
//        return
//    }
//
//    if let httpResponse = response as? HTTPURLResponse {
//        print("Status Code: \(httpResponse.statusCode)")
//    }
//
//    if let data = data {
//        let responseString = String(data: data, encoding: .utf8)
//        print("Response Data: \(responseString!)")
//    }
//}
//task.resume()


//actor OrderProcessor {
//        private var orders: [String] = []
//    
//    // 주문 추가 메서드
//    func addOrder(_ order: String) {
//            orders.append(order)
//            print("추가된 주문: \(order)")
//    }
//
//    // 주문 처리 메서드
//    func processOrder() {
//        if orders.isEmpty {
//                print("처리할 주문 없음")
//        } else {
//                let order = orders.removeFirst()
//                print("처리된 주문: \(order)")
//        }
//    }
//
//    // 현재 남아있는 주문 출력 메서드
//    func printAllOrder() {
//        if orders.isEmpty {
//                print("남아 있는 주문 없음")
//        } else {
//                print("남아 있는 주문: \(orders.joined(separator: ", "))")
//        }
//    }
//}
//
//let orderProcessor = OrderProcessor()
//
//Task {
//    // 1. 주문 추가
//    await orderProcessor.addOrder("Pizza")
////    await orderProcessor.addOrder("Burger")
////    await orderProcessor.addOrder("Pasta")
////
////    // 2. 주문 처리
////    await orderProcessor.processOrder() // Pizza 처리
////    await orderProcessor.processOrder() // Burger 처리
////
////    // 3. 남은 주문 확인
////    await orderProcessor.printAllOrder() // Pasta 남음
////
////    // 4. Pasta 처리
////    await orderProcessor.processOrder()
////    await orderProcessor.processOrder()
////    // 5. 최종 남은 주문 확인
////    await orderProcessor.printAllOrder()
////}
//
//import Foundation
//
//// DTO 구조체 정의
//struct UserDTO: Codable {
//    let name: String
//    let age: Int
//    let address: String
//    let height: Double
//}
//
//// actor 정의
//actor NetworkManager {
//    func getUserData() async throws -> String {
//        var urlComponents = URLComponents(string: "http://localhost:8080/person")!
//        urlComponents.queryItems = [
//            URLQueryItem(name: "name", value: "제옹")
//        ]
//        
//        guard let url = urlComponents.url else {
//            throw URLError(.badURL)
//        }
//        
//        let (data, response) = try await URLSession.shared.data(from: url)
//        
//        guard let httpResponse = response as? HTTPURLResponse,
//              (200...299).contains(httpResponse.statusCode) else {
//            throw URLError(.badServerResponse)
//        }
//        
//        guard let responseString = String(data: data, encoding: .utf8) else {
//            throw URLError(.cannotDecodeContentData)
//        }
//        
//        return responseString
//    }
//
//    // ✅ POST 요청 메서드
//    func postUserData(user: UserDTO) async throws -> String {
//        guard let url = URL(string: "http://localhost:8080/person") else {
//            throw URLError(.badURL)
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let encodedData = try JSONEncoder().encode(user)
//        request.httpBody = encodedData
//
//        let (data, response) = try await URLSession.shared.data(for: request)
//
//        guard let httpResponse = response as? HTTPURLResponse,
//              (200...299).contains(httpResponse.statusCode) else {
//            throw URLError(.badServerResponse)
//        }
//
//        guard let responseString = String(data: data, encoding: .utf8) else {
//            throw URLError(.cannotDecodeContentData)
//        }
//
//        return responseString
//    }
//}
//
//// 호출 예시
//let networkManager = NetworkManager()
//
//Task {
//    do {
//        let user = UserDTO(name: "제옹", age: 29, address: "포항시 대잠동", height: 178)
//        let result = try await networkManager.postUserData(user: user)
//        print("POST 응답 데이터:", result)
//    } catch {
//        print("POST 네트워크 에러:", error)
//    }
//}



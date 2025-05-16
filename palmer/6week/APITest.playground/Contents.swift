/*
 //Post Method
import SwiftUI

let url = URL(string: "http://localhost:8080/person")!
var request = URLRequest(url: url)
request.httpMethod = "POST"

let parameters: [String: Any] = [
      "name": "파머",
      "age": 24,
      "address": "서울특별시",
      "height": 180
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

/*
//Get Method
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

/*
//Patch Method
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

/*
//Put Method
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

/*
//Delete Method
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

// 한 번에 하나씩만 처리되게 순서를 보장하고 싶어!(Actor)
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


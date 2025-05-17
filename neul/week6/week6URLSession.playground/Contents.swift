import SwiftUI


/*

let url = URL(string: "http://localhost:8080/person")!
var request = URLRequest(url: url)
request.httpMethod = "POST"

let parameters: [String: Any] = [
      "name": "토끼짱",
      "age": 25,
      "address": "홍대~~",
      "height": 155
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

/*var urlComponents = URLComponents(string: "http://localhost:8080/person")!
urlComponents.queryItems = [
    URLQueryItem(name: "name", value: "토끼짱")
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
task.resume()*/


/*
let url = URL(string: "http://localhost:8080/person")!
var request = URLRequest(url: url)
request.httpMethod = "PATCH"

let parameters: [String: Any] = [
    "name": "서현",
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
task.resume()*/


/*
let url = URL(string: "http://localhost:8080/person")!
var request = URLRequest(url: url)
request.httpMethod = "PUT"

// 요청 본문에 전송할 데이터
let parameters: [String: Any] = [
    "name": "서현",
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
var urlComponents = URLComponents(string: "http://localhost:8080/person")!
urlComponents.queryItems = [
    URLQueryItem(name: "name", value: "서현")
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
task.resume()*/


actor NetworkManager {
    func getUserData() async throws -> String {
        var urlComponents = URLComponents(string: "http://localhost:8080/person")!
        urlComponents.queryItems = [
            URLQueryItem(name: "name", value: "토끼짱")
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
    
    
    
    func saveUserData() async throws -> String {
        let url = URL(string: "http://localhost:8080/person")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        let parameters: [String: Any] = [
              "name": "토끼짱",
              "age": 25,
              "address": "홍대~~",
              "height": 155
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        guard let responseString = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        return responseString
    }
    
    func deleteUserData() async throws -> String {
        var urlComponents = URLComponents(string: "http://localhost:8080/person")!
        urlComponents.queryItems = [
            URLQueryItem(name: "name", value: "토끼짱")
        ]

        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
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
        let result = try await networkManager.deleteUserData()
        print("응답 데이터:", result)
    } catch {
        print("네트워크 에러", error)
    }
}

import UIKit

actor NetworkManager {
    func getUserData() async throws -> String {
        var urlComponents = URLComponents(string: "http://localhost:8080/person")!
        urlComponents.queryItems = [
            URLQueryItem(name: "name", value: "potato")
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
            throw URLError(.badServerResponse)
        }
        
        return responseString
    }
    
    func postUser() async throws -> String {
        let url = URL(string: "http://localhost:8080/person")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters: [String: Any] = [
            "name": "potato",
            "age": 25,
            "address": "서울시 노원구",
            "height": 123
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        guard let responseString = String(data: data, encoding: .utf8) else {
            throw URLError(.badServerResponse)
        }
        
        return responseString
    }
    
    func deleteUser() async throws -> String {
        var urlComponents = URLComponents(string: "http://localhost:8080/person")!
        urlComponents.queryItems = [
            URLQueryItem(name: "name", value: "potato")
        ]
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        guard let responseString = String(data: data, encoding: .utf8) else {
            throw URLError(.badServerResponse)
        }
        
        return responseString
    }
}

let networkManager = NetworkManager()

Task {
    do {
        let result = try await networkManager.deleteUser()
        print("응답 데이터:", result)
    } catch {
        print("네트워크 에러", error)
    }
}

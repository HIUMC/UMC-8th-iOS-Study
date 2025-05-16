import Foundation

actor NetworkManager {
    
    // MARK: - GET (조회)
    func getUserData(name: String) async throws -> String {
        var urlComponents = URLComponents(string: "http://localhost:8080/person")!
        urlComponents.queryItems = [
            URLQueryItem(name: "name", value: name)
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

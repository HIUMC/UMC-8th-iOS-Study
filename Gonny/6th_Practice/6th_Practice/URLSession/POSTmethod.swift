//
//  POSTmethod.swift
//  6th_Practice
//
//  Created by 박병선 on 5/16/25.
//지금 한 파일에 메서드를 여러 개 때려넣어서 오류 있을 수 밖에 없는데 이게 맞아...
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

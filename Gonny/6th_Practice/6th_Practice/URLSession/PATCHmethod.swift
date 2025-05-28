//
//  d.swift
//  6th_Practice
//
//  Created by 박병선 on 5/16/25.
//
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

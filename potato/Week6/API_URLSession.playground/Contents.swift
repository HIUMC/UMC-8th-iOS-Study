import UIKit

/* POST
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
*/

/* GET
var urlComponents = URLComponents(string: "http://localhost:8080/person")!
urlComponents.queryItems = [
    URLQueryItem(name: "name", value: "potato")
]

// let url = urlComponents.url!
// 위 코드는 아래 task에서 인자가 달라진다
// let task = URLSession.shared.dataTask(with: url)
let request = URLRequest(url: urlComponents.url!)
 */

/* PATCH
let url = URL(string: "http://localhost:8080/person")!
var request = URLRequest(url: url)
request.httpMethod = "PATCH"

let parameters: [String: Any] = [
    "age": 20
]

request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 */

/* PUT
let url = URL(string: "http://localhost:8080/person")!
var request = URLRequest(url: url)
request.httpMethod = "PUT"

let parameters: [String: Any] = [
    "name": "감자",
    "age": 25,
    "address": "서울시 노원구",
    "height": 123
]

request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 */

/* DELETE */
var urlComponents = URLComponents(string: "http://localhost:8080/person")!
urlComponents.queryItems = [
    URLQueryItem(name: "name", value: "감자")
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
        print("상태 코드: \(httpResponse.statusCode)")
    }
    
    if let data = data {
        let responseString = String(data: data, encoding: .utf8)
        print("응답: \(responseString!)")
    }
}

task.resume()

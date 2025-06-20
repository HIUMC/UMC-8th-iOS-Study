//
//  GETmethod.swift
//  6th_Practice
//
//  Created by 박병선 on 5/16/25.
//
import SwiftUI

//URL 생성, URLComponent를 사용해서 URL을 세분화하여 조립함,  쿼리아이템은 쿼리파미터를 추가하는 부분
//최종 URL은 http://localhost:8080/person?name=제옹
var urlComponents = URLComponents(string: "http://localhost:8080/person")!
urlComponents.queryItems = [
    URLQueryItem(name: "name", value: "제옹")
]

//최종 URL 완성
let url = urlComponents.url!

//URLSession을 통한 비동기 요청
//dataTask는 서버로부터 응답을 받았을 때 실행할 콜백을 포함
let task = URLSession.shared.dataTask(with: url) { data, response, error in
    //에러처리
    if let error = error {
        print("에러: \(error)")
        return
    }
//응답상태코드 확인
    if let httpResponse = response as? HTTPURLResponse {
        print("상태 코드: \(httpResponse.statusCode)")
    }
//받은 응답 데이터를 String으로 변환해 출력, 예를 들어 서버가 {"message":"hello, JEong"} 이런 JSON 문자열을 응답할 수 있음
    if let data = data {
        let responseString = String(data: data, encoding: .utf8)
        print("응답: \(responseString!)")
    }
}
//dataTask는 생성만 하면 바로 실행되지 않기 때문에 .resume()을 호출해서 네트워크 요청을 시작해야함
task.resume()


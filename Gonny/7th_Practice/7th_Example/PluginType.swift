//
//  PluginType.swift
//  7th_Example
//
//  Created by 박병선 on 5/27/25.
//
//pluginType을 통해 모든 API 요청/응답의 전후 처리 로직을 삽입할 수 있는 구조를 제공
import Moya
import Foundation

final class DebugPlugin: PluginType {
    
    // 1. 요청 객체가 생성되기 직전 → URLRequest 수정 가능(헤더,URL 등을 변경할 수 있음)
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        print("[prepare] 요청 준비 중: \(request.url?.absoluteString ?? "")")
        return request
    }

    // 2. 네트워크 요청이 시작되기 직전(콘솔 로그 출력)
    func willSend(_ request: RequestType, target: TargetType) {
        print("[willSend] 요청 시작: \(request.request?.url?.absoluteString ?? "")")
    }

    // 3. 네트워크 응답이 도착한 직후(결과 분석, 실패로깅 등)
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            print("[didReceive] 응답 성공: \(response.statusCode)")
        case .failure(let error):
            print("[didReceive] 응답 실패: \(error.localizedDescription)")
        }
    }

    // 4. 응답 결과를 가공할 수 있음(응답을 수정하거나 에러메세지를 가공)
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        print("[process] 응답 후처리 중")
        return result
    }
}

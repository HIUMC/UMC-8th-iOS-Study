import Moya
import Foundation

final class DebugPlugin: PluginType {
    
    // 1. 요청 객체가 생성되기 직전 → URLRequest 수정 가능
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        let request = request
        print("[prepare] 요청 준비 중: \(request.url?.absoluteString ?? "")")
        return request
    }

    // 2. 네트워크 요청이 시작되기 직전
    func willSend(_ request: RequestType, target: TargetType) {
        print("[willSend] 요청 시작: \(request.request?.url?.absoluteString ?? "")")
    }

    // 3. 네트워크 응답이 도착한 직후
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            print("[didReceive] 응답 성공: \(response.statusCode)")
        case .failure(let error):
            print("[didReceive] 응답 실패: \(error.localizedDescription)")
        }
    }

    // 4. 응답 결과를 가공할 수 있음
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        print("[process] 응답 후처리 중")
        return result
    }
}

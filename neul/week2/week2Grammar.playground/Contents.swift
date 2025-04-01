import Foundation



enum NetworkState {
    case idle
    case requesting
    case success(String)
    case failure(String)
}


var currentState: NetworkState = .success("데이터 로드 완료")



switch currentState {
case .idle:
    print("현재 대기 상태입니다.")
case .requesting:
    print("요청 중입니다...")
case .success(let success):
    print("요청 성공: \(success)")
case .failure(let error):
    print("요청 실패: \(error)")
}

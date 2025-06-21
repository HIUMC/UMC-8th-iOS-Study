//
//  SSL.swift
//  StarbuckApp
//
//  Created by 박병선 on 6/20/25.
//

import Foundation
import Alamofire

class RedirectHandlerExample {
    private let session: Session
    
    init() {
        // 1. 리다이렉트 차단 설정
        let redirector = Redirector(behavior: .doNotFollow)
        
        // 2. Session 구성
        self.session = Session(redirectHandler: redirector)
    }
    
    func sendRequest() {
        // 3. 요청 실행 (리다이렉트가 있어도 따르지 않음)
        session.request("http://블라블라.com")
            .response { response in
                if let httpResponse = response.response {
                    print("리다이렉트 차단됨:", httpResponse.statusCode)
                } else if let error = response.error {
                    print("요청 실패:", error.localizedDescription)
                } else {
                    print("응답 수신 완료")
                }
            }
    }
}

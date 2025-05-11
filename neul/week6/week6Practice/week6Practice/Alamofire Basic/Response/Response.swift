//
//  Response.swift
//  week6Practice
//
//  Created by tokkislove on 5/8/25.
//

import Alamofire
import Foundation

//MARK: Response Validation
struct SomeModel: Codable {
    let id: Int
    let name: String
}


func fetchData() async {
    do {
        let response = try await AF.request("https://blahblah.com")
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .serializingDecodable(SomeModel.self)
            .value
        
        print("성공")
    } catch {
        print("오류", error.localizedDescription)
    }
}

//MARK: Multipart Form

func uploadProfile(name: String, fileUrl: URL) async {
    do {
        let response = try await AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(Data(name.utf8), withName: "name")
                multipartFormData.append(fileUrl, withName: "profileImage", fileName: "profile.jpg", mimeType: "image/jpeg")
            },
            to: "https://example.com"
        )
            .validate(statusCode: 200..<300)
            .serializingString()
            .value
        
        print("파일 업로드 성공", response)
    } catch {
        print("파일 업로드 실패", error.localizedDescription)
    }
}

//MARK: Response Retriers

protocol TokenProviding {
    var accessToken: String? { get }
}

final class RequestRetrierHandler: RequestInterceptor {
    private let tokenProviding: TokenProviding
    
    init(tokenProviding: TokenProviding) {
        self.tokenProviding = tokenProviding
    }
    
    //1. 요청에 authorization 헤더 추가
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        
        if let accessToken = tokenProviding.accessToken {
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        completion(.success(urlRequest))
    }
    
    // 2. 401 에러 발생 시 재시도
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        if let response = request.task?.response as? HTTPURLResponse,
           response.statusCode == 401 {
            print("401 에러, 재시도 수행")
            completion(.retry)
        } else {
            completion(.doNotRetry)
        }
    }
}

// 사용할 때?
/*
 let session = Session(interceptor: RequestRetrierHandler())

 session.request("https://블라블라.com/블라블라")
     .validate()
     .response { response in
         /* 응답 처리 코드 작성하여 사용하면 됩니다 */
     }
 */

/*
 요런 식으로:
 import UIKit
 import Alamofire

 class MyViewController: UIViewController {
     private let session = Session(interceptor: RequestRetrierHandler())

     override func viewDidLoad() {
         super.viewDidLoad()
         fetchData()
     }

     private func fetchData() {
         session.request("https://블라블라.com/블라블라")
             .validate()
             .response { response in
                 switch response.result {
                 case .success(let data):
                     print("성공:", data)
                 case .failure(let error):
                     print("오류:", error.localizedDescription)
                 }
             }
     }
 }
 */

//MARK: Request Caching

/*let configuration = URLSessionConfiguration.default
// 캐싱 동작을 제어
configuration.requestCachePolicy = .returnCacheDataElseLoad
//HTTP 응답을 캐싱해~~
configuration.urlCache = URLCache(memoryCapacity: 10 * 1024 * 1024,
                                  diskCapacity: 50 * 1024 * 1024,
                                  diskPath: "urlCache")


let session = Session(configuration: configuration)

session.request("https://블라블라.com/data")
    .response { response in
        print("응답 수신 완료")
    }
*/


//MARK: Session Configuration
/*
let configuration = URLSessionConfiguration.default
configuration.timeoutIntervalForRequest = 15   // 요청 타임아웃
configuration.headers = .default               // 기본 헤더
configuration.requestCachePolicy = .returnCacheDataElseLoad

let session = Session(configuration: configuration) //네트워크 설정 커스터마이징

session.request("https://example.com")
    .response { response in
        print("응답 완료")
    }
*/


//MARK: Session Dispatch Queue
//-> 응답 처리 콜백을 특정 queue에서 실행되도록.
final class ResponseQueueExample {
    private let session: Session

    init() {
        // 1. 백그라운드 큐 정의
        let backgroundQueue = DispatchQueue(label: "com.블라블라.responseQueue")

        // 2. 해당 큐를 rootQueue로 사용하는 Session 생성
        self.session = Session(rootQueue: backgroundQueue)
    }

    func sendRequest() {
        session.request("https://블라블라.com/api/data")
            .validate()
            .responseDecodable(of: SomeModel.self) { response in
                print("백그라운드 큐에서 응답 처리됨")

                switch response.result {
                case .success(let model):
                    // 메인 큐에서 UI 작업
                    DispatchQueue.main.async {
                        print("메인 스레드에서 모델 사용: \(model)")
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        print("오류 발생: \(error.localizedDescription)")
                    }
                }
            }
    }
}

//MARK: Redirect Handling
//이미 내장되어 있음
public enum Behavior {
    case follow
    case doNotFollow
    case modify((URLSessionTask, URLRequest, HTTPURLResponse) -> URLRequest?)
}

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


final class RedirectFollowExample {
    private let session: Session

    init() {
        let redirector = Redirector(behavior: .follow) // 리다이렉트 허용
        self.session = Session(redirectHandler: redirector)
    }

    func sendRequest() {
        session.request("http://블라블라.com")
            .response { response in
                if let httpResponse = response.response {
                    print("리다이렉트 허용됨:", httpResponse.statusCode)
                } else {
                    print("응답 없음")
                }
            }
    }
}


final class RedirectModifyExample {
    private let session: Session

    init() {
        // 조건에 따라 Authorization 헤더 추가
        let redirector = Redirector(behavior: .modify { task, request, response in
            var modifiedRequest = request
            modifiedRequest.setValue("Bearer token123", forHTTPHeaderField: "Authorization")
            print("리다이렉트 수정됨, 토큰 포함")
            return modifiedRequest
        })

        self.session = Session(redirectHandler: redirector)
    }

    func sendRequest() {
        session.request("http://블라블라.com/redirect")
            .response { response in
                if let httpResponse = response.response {
                    print("리다이렉트 후 응답 수신:", httpResponse.statusCode)
                } else if let error = response.error {
                    print("에러 발생:", error.localizedDescription)
                } else {
                    print("응답 없음")
                }
            }
    }
}

//MARK: SSL 인증
class SSL {
    private let session: Session

    init() {
        let evaluators: [String: ServerTrustEvaluating] = [
            "example.com": PinnedCertificatesTrustEvaluator()
        ]
        let trustManager = ServerTrustManager(evaluators: evaluators)
        self.session = Session(serverTrustManager: trustManager)
    }

    func sendRequest() {
        session.request("https://example.com")
            .validate()
            .response { response in
                print("보안 검증된 응답")
            }
    }
}

//
//  ServiceManager.swift
//  StarbuckApp
//
//  Created by 박병선 on 6/20/25.
//
import Foundation
import Combine
import Moya
import CombineMoya


enum PersonAPI {
    case getUser(name: String)
    case postUser(user: UserDTO)
    case putUser(user: UserDTO)
    case patchUser(name: String)
    case deleteUser(name: String)
}

extension PersonAPI: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }

    var path: String {
        return "/person"
    }

    var method: Moya.Method {
        switch self {
        case .getUser:       return .get
        case .postUser:      return .post
        case .putUser:       return .put
        case .patchUser:     return .patch
        case .deleteUser:    return .delete
        }
    }

    var task: Task {
        switch self {
        case .getUser(let name):
            return .requestParameters(parameters: ["name": name], encoding: URLEncoding.default)
        case .postUser(let user), .putUser(let user):
            return .requestJSONEncodable(user)
        case .patchUser(let name):
            return .requestParameters(parameters: ["name": name], encoding: JSONEncoding.default)
        case .deleteUser(let name):
            return .requestParameters(parameters: ["name": name], encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }

    var sampleData: Data { Data() }
}
final class ServiceManager {
    static let shared = ServiceManager()
    private let provider = MoyaProvider<PersonAPI>()
    
    private init() {}

    private var cancellables = Set<AnyCancellable>()
    
    // GET 요청
    func getUser(name: String) -> AnyPublisher<UserDTO, Error> {
        provider.requestPublisher(.getUser(name: name))
            .map(\.data)
            .decode(type: UserDTO.self, decoder: JSONDecoder())
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    // POST 요청
    func postUser(user: UserDTO) -> AnyPublisher<String, Error> {
        provider.requestPublisher(.postUser(user: user))
            .map(\.data)
            .compactMap { String(data: $0, encoding: .utf8) }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    // PUT 요청
    func putUser(user: UserDTO) -> AnyPublisher<String, Error> {
        provider.requestPublisher(.putUser(user: user))
            .map(\.data)
            .compactMap { String(data: $0, encoding: .utf8) }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    // PATCH 요청
    func patchUser(name: String) -> AnyPublisher<String, Error> {
        provider.requestPublisher(.patchUser(name: name))
            .map(\.data)
            .compactMap { String(data: $0, encoding: .utf8) }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    // DELETE 요청
    func deleteUser(name: String) -> AnyPublisher<String, Error> {
        provider.requestPublisher(.deleteUser(name: name))
            .map(\.data)
            .compactMap { String(data: $0, encoding: .utf8) }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
/*
import Foundation
import Alamofire

final class ServiceManager {
    
    static let shared = ServiceManager()
    
    private let session: Session
    private let urlString: String = "\(Config.baseURL)/person"
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        
        self.session = Session(configuration: configuration)
    }
    
    // MARK: - GET 요청
    func getUser(name: String) async {
        let parameters: [String: String] = [
            "name": name
        ]
        
        do {
            let user = try await session.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.default)
                .serializingDecodable(UserDTO.self)
                .value
            print("GET 성공:", user)
        } catch {
            print("GET 실패:", error.localizedDescription)
        }
    }
    
    // MARK: - POST 요청
    func postUser(user: UserDTO) async {
        do {
            let response = try await session.request(urlString, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
                .serializingString()
                .value
            print("POST 성공:", response)
        } catch {
            print("POST 실패:", error.localizedDescription)
        }
    }
    
    // MARK: - PUT 요청
    func putUser(user: UserDTO) async {
        do {
            let response = try await session.request(urlString, method: .put, parameters: user, encoder: JSONParameterEncoder.default)
                .serializingString()
                .value
            print("PUT 성공:", response)
        } catch {
            print("PUT 실패:", error.localizedDescription)
        }
    }
    
    // MARK: - PATCH 요청
    func patchUser(name: String) async {
        let parameters: [String: String] = [
            "name": name
        ]
        
        do {
            let response = try await session.request(urlString, method: .patch, parameters: parameters, encoding: JSONEncoding.default)
                .serializingString()
                .value
            print("PATCH 성공:", response)
        } catch {
            print("PATCH 실패:", error.localizedDescription)
        }
    }
    
    // MARK: - DELETE 요청
    func deleteUser(name: String) async {
        let parameters: [String: String] = [
            "name": name
        ]
        
        do {
            let response = try await session.request(urlString, method: .delete, parameters: parameters, encoding: URLEncoding.default)
                .serializingString()
                .value
            print("DELETE 성공:", response)
        } catch {
            print("DELETE 실패:", error.localizedDescription)
        }
    }
}
*/

//
//  UserRouter.swift
//  MoyaTest
//
//  Created by 이서현 on 5/19/25.
//

import Foundation
import Moya



enum UserRouter {
    case getPerson(name: String)
    case postPerson(userData: UserData)
    case patchPerson(patchData: UserPatchRequest)
    case putPerson(userData: UserData)
    case deletePerson(name: String)
}

extension UserRouter: APITargetType {
    var path: String {
        return "/person"
    }
    
    var method: Moya.Method {
        switch self {
        case .getPerson:
            return .get
        case .postPerson:
            return .post
        case .patchPerson:
            return .patch
        case .putPerson:
            return .put
        case .deletePerson:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .getPerson(let name), .deletePerson(let name):
            return .requestParameters(parameters: ["name": name], encoding: URLEncoding.queryString)
        case .postPerson(let userData), .putPerson(let userData):
            return .requestJSONEncodable(userData)
        case .patchPerson(let patchData):
            return .requestJSONEncodable(patchData)
        }
    }
}

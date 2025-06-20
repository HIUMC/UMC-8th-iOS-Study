//
//  MoyaProvider.swift
//  MoyaTest
//
//  Created by 박병선 on 5/27/25.
//
import Foundation
import Moya

@Observable
class ContentsViewModel {
    var userData: UserData?
    let provider: MoyaProvider<UserRotuer>
    
    init() {
        let logger = NetworkLoggerPlugin(configuration: .init(logOptions: [.verbose]))
        self.provider = MoyaProvider<UserRotuer>(plugins: [logger])
    }
}

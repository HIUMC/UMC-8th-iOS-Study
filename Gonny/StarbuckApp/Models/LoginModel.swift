//
//  LoginModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/24/25.
//

import Foundation

struct LoginModel: Codable {
    var id: String
    var pwd: String

    init(id: String = "", pwd: String = "") {
        self.id = id
        self.pwd = pwd
    }
}



//
//  KakaoInfoModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/19/25.
//

import Foundation
// MARK: - Kakao User Info Models

struct KakaoUserResponse: Decodable {
    let id: Int
    let kakao_account: KakaoAccount
}

struct KakaoAccount: Decodable {
    let profile: KakaoProfile
}

struct KakaoProfile: Decodable {
    let nickname: String
}

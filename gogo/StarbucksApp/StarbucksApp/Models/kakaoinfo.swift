//
//  kakaoinfo.swift
//  StarbucksApp
//
//  Created by 고석현 on 5/28/25.


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

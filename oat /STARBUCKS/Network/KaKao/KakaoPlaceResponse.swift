//
//  KakaoPlaceResponse.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/22/25.
//

import Foundation

// 최상위 응답 객체
struct KakaoPlaceResponse: Codable {
    let documents: [Place]  // 각 장소 정보를 담고 있는 배열
}

//
//  KakaoSearchResponse.swift
//  StarbuckApp
//
//  Created by 박병선 on 5/27/25.
//
import Foundation

//출발지 검색 시에 사용
struct KakaoSearchResponse: Codable {
    let documents: [Place]
}

struct Place: Codable, Identifiable {
    var id: String { place_name + address_name } // 고유 ID 생성
    let place_name: String
    let address_name: String
    let x: String  // longitude
    let y: String  // latitude
}

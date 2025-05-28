//
//  Place.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/19/25.


//카카오 api로 받은 걸 (JSON 형태) Place 구조체로 디코딩해서 사용하기
import Foundation
import CoreLocation

struct Place: Codable, Identifiable {
    let id = UUID()
    let placeName: String
    let addressName: String      
    let x: String
    let y: String

    enum CodingKeys: String, CodingKey {
        case placeName = "place_name"
        case addressName = "address_name"
        case x, y
    }

    var coordinate: CLLocationCoordinate2D? {
        guard let lon = Double(x), let lat = Double(y)
        else { return nil }
        // 우리가 쓸 좌표 객체로 바꿔주기/! 
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}



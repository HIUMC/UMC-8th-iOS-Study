//
//  StoreModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 4/28/25.
//
import Foundation
import CoreLocation // 위도/경도 타입

// 매장을 나타내는 데이터 구조
// Decodable : JSON 데이터를 이 구조로 디코딩 할 수 있게 함
struct Store: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let address: String
    let latitude: Double //위도
    let longitude: Double //경도
    let category: StoreCategory
    
    enum CodingKeys: String, CodingKey {
        case properties
    // JSON에서 properties 키를 찾아내기 위한 단계
    
        //Properties 내부에 있는 각 필드 이름을 JSON 키와 연결
        enum PropertiesKeys: String, CodingKey {
            case name = "Sotre_nm"
            //예) JSON의 Sotre_nm은 swift 의 name과 연결
            case address = "Address"
            case category = "Category"
            case latitude = "Ycoordinate"
            case longitude = "Xcoordinate"
        }
    }
    
    init(name: String, address: String, latitude: Double, longitude: Double, category: StoreCategory) {
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.category = category
    }

    //JSON 파싱 전용 생성자
    init(from decoder: Decoder) throws {
        //JSON을 Store 객체로 변환하는데 사용되는 디코더 전용 초기화 함수
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //1. JSON 최상위 -> prooerties 키 찾기
        let properties = try container.nestedContainer(keyedBy: CodingKeys.PropertiesKeys.self, forKey: .properties)
        //2. properties 내부에서 매장 정보 읽기
        name = try properties.decode(String.self, forKey: .name)
        address = try properties.decode(String.self, forKey: .address)
        // 매장 이름, 주소 디코딩
        
        let categoryString = try properties.decode(String.self, forKey: .category)
        
        if categoryString == "리저브 매장" {
            category = .reserve
        } else if categoryString == "DT 매장" {
            category = .driveThru
        } else {
            category = .normal
        }
        //categoryString 카테고리 문자열을 enum 으로 변환시킨다
        // enum 타입 reserve, dreiveThru, normal 로 매핑한다
        
        latitude = try properties.decode(Double.self, forKey: .latitude)
        longitude = try properties.decode(Double.self, forKey: .longitude)
        //위도 경도 값을 JSON에서 읽어와 저장함
    }
}

//매장 유형을 나타내는 열거형
//JSON에서 문자열로 들어올 때 자동으로 enum 매핑하기 
enum StoreCategory: String, Decodable {
    case reserve = "R"   // 리저브
    case driveThru = "D" // 드라이브스루
    case normal = "" 
}



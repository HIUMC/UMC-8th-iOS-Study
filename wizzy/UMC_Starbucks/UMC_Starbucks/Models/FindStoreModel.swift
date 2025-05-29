//
//  FindStoreModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/20/25.
//

//
//  BookModel.swift
//  6st_Practice
//
//  Created by Apple Coding machine on 5/4/25.
//

import Foundation

struct FindStoreModel: Codable {
    let documents: [Documents]
    let meta: Meta
    
    // MARK: - Meta 정보
    
    struct Meta: Codable {
        let isEnd: Bool?
        let pageableCount: Int?
        let totalCount: Int?

        enum CodingKeys: String, CodingKey {
            case isEnd = "is_end"
            case pageableCount = "pageable_count"
            case totalCount = "total_count"
        }
    }
    
    // MARK: - Documents 정보
    
    struct Documents: Codable {
        let id: String
        let placeName: String
        let categoryName: String
        let categoryGroupName: String
        let phone: String
        let addressName: String
        let roadAddressName: String
        let x: String
        let y: String
        let placeURL: String
        let distance: String

        enum CodingKeys: String, CodingKey {
            case id
            case placeName = "place_name"
            case categoryName = "category_name"
            case categoryGroupName = "category_group_name"
            case phone
            case addressName = "address_name"
            case roadAddressName = "road_address_name"
            case x, y
            case placeURL = "place_url"
            case distance
        }
    }
}

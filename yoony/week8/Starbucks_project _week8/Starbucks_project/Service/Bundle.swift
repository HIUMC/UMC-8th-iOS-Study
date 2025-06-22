//
//  Bundle.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/29/25.
//
import Foundation

extension Bundle {
    var googleAPIKey: String {
        return infoDictionary?["GOOGLE_API_KEY"] as? String ?? ""
    }

    var imageURL: String {
        guard let url = infoDictionary?["Image_URL"] as? String else {
            fatalError("❌ Info.plist에 'Image_URL' 키가 없거나 형식이 잘못되었습니다.")
        }
        return url
    }
}

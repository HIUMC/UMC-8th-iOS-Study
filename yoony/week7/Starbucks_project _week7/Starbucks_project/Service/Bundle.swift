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
}


//
//  RouteModel.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/29/25.
//

import Foundation

struct RouteModel: Codable {
    let routes: [Route]
    
    struct Route: Codable {
        let distance: Double
        let duration: Double
    }
}

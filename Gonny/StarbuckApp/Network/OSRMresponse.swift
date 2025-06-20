//
//  OSRMresponse.swift
//  StarbuckApp
//
//  Created by 박병선 on 5/27/25.
//
import Foundation
import SwiftUI

struct OSRMRouteResponse: Codable {
    let routes: [OSRMRoute]
}

struct OSRMRoute: Codable {
    let distance: Double   // meters
    let duration: Double   // seconds
    let geometry: OSRMGeometry
}

struct OSRMGeometry: Codable {
    let coordinates: [[Double]]  // [longitude, latitude]
    let type: String
}

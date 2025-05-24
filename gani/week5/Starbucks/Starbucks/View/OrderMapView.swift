//
//  OrderMapView.swift
//  Starbucks
//
//  Created by 이가원 on 5/24/25.
//
import SwiftUI
import MapKit

struct OrderMapView: View {
    
    private var locationManager = LocationManager()
        
    var body: some View {
        Map(initialPosition: .region(locationManager.region))
        }
}

#Preview {
    OrderMapView()
}

//
//  CustomMap.swift
//  MapExample
//
//  Created by 주민영 on 4/10/25.
//

import SwiftUI
import MapKit

struct CustomMap: UIViewRepresentable {
    let mapView = MKMapView()
    
    @Bindable var locationManager: LocationManager
    
    
    func makeUIView(context: Context) -> MKMapView {
        
        mapView.delegate = context.coordinator
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        mapView.isRotateEnabled = false
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, CLLocationManagerDelegate, MKMapViewDelegate {
    }
}

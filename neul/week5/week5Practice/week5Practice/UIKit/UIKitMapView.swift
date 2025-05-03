//
//  UIKitMapView.swift
//  week5Practice
//
//  Created by tokkislove on 4/28/25.
//

import SwiftUI
import MapKit

struct UIKitMapView: View {
    
    @Bindable private var locationManager = LocationManager.shared
    
    var body: some View {
        ZStack {
            CustomMap(locationManager: locationManager)
                .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    UIKitMapView()
}

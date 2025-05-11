//
//  CustomMapView.swift
//  UMC-iOS-WorkBook-5
//
//  Created by 곽은채 on 4/28/25.
//

import SwiftUI
import MapKit

struct CustomMapView: View {
    @Bindable private var locationManager = LocationManager.shared
    
    var body: some View {
        ZStack {
            CustomMap(locationManager: locationManager)
                .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    CustomMapView()
}

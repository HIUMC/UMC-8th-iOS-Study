//
//  ContentView.swift
//  week5Practice
//
//  Created by tokkislove on 4/28/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    private var locationManager = LocationManager()
    
    var body: some View {
        //Map(initialPosition: .region(locationManager.region))
        Text("contentView")
    }
}

#Preview {
    ContentView()
}

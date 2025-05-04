//
//  ContentView.swift
//  UMC-iOS-WorkBook-5
//
//  Created by 곽은채 on 4/28/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    var body: some View {
        Map(initialPosition: .region(region))
    }
}

#Preview {
    ContentView()
}

//
//  MapView.swift
//  Starbucks
//
//  Created by 김영택 on 5/3/25.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @StateObject private var locationManager = LocationManager()
    @ObservedObject var viewModel: JSONParsingViewModel

    var body: some View {
        Map(coordinateRegion: $locationManager.region, annotationItems: filteredStores()) { store in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: store.latitude, longitude: store.longitude)) {
                Image(systemName: "mappin.circle.fill")
                    .foregroundColor(.green)
                    .imageScale(.large)
                    .overlay(Text(store.storeName).font(.caption2).offset(y: 20))
            }
        }
        .overlay(
            Group {
                if let userLocation = locationManager.userLocation {
                    Circle()
                        .stroke(Color.blue, lineWidth: 3)
                        .frame(width: 20, height: 20)
                        .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
                }
            }
        )
        .edgesIgnoringSafeArea(.all)
    }

    func filteredStores() -> [MyModel] {
        guard let userLocation = locationManager.userLocation else { return [] }
        return viewModel.sortedByDistance(from: CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude))
    }
}



#Preview {
    MapView(viewModel: JSONParsingViewModel())
}

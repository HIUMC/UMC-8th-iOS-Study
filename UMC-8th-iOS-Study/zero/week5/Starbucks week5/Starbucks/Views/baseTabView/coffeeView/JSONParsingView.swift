//
//  JSONParsingView.swift
//  Starbucks
//
//  Created by 김영택 on 5/3/25.
//

import SwiftUI
import CoreLocation

struct JSONParsingView: View {
    @StateObject var viewModel = JSONParsingViewModel()
    @StateObject var locationManager = LocationManager()

    var body: some View {
        NavigationView {
            VStack {
                if let userLocation = locationManager.userLocation {
                    // userLocation을 CLLocation으로 변환
                    let userCLLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
                    let sortedStores = viewModel.sortedByDistance(from: userCLLocation)

                    List(sortedStores, id: \.self) { store in
                        HStack(spacing: 16) {
                            Image(systemName: "seoul")
                                .resizable()
                                .frame(width: 50, height: 50)

                            VStack(alignment: .leading) {
                                Text(store.storeName)
                                    .font(.headline)
                                if let distance = distance(from: userCLLocation, to: store) { // userLocation을 userCLLocation으로 변경
                                    Text(String(format: "%.2f km", distance / 1000))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }

                } else {
                    ProgressView("현재 위치 불러오는 중...")
                }
            }
            .onAppear {
                viewModel.loadStores()
            }
        }
    }

    func distance(from location: CLLocation, to store: MyModel) -> Double? {
        let storeLocation = CLLocation(latitude: store.latitude, longitude: store.longitude)
        return location.distance(from: storeLocation)
    }
}

#Preview {
    JSONParsingView()
}

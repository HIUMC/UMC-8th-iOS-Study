//
//  LocationInputView.swift
//  StarbuckApp
//
//  Created by 박병선 on 5/20/25.
//

import SwiftUI

struct LocationInputView: View {
    @ObservedObject private var locationManager = LocationManager.shared
    
    @State private var startAddress: String = ""

    var body: some View {
        VStack(spacing: 20) {
            TextField("출발지를 입력하세요", text: $startAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button(action: {
                locationManager.requestCurrentLocation()
            }) {
                Label("현재 위치 가져오기", systemImage: "location.fill")
            }
        }
        .onReceive(locationManager.$currentAddress) { address in
                    self.startAddress = locationManager.currentAddress
                }
    }
}

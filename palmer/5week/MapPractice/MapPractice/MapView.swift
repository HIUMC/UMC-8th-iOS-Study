//
//  MapView.swift
//  MapPractice
//
//  Created by 박정환 on 4/30/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @Bindable private var locationManager = LocationManager.shared
    @Bindable private var viewModel: MapViewModel = .init()
    @Namespace var mapScope
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(position: $viewModel.cameraPosition, scope: mapScope) {
                //현재 위치 마커
                ForEach(viewModel.makers, id: \.id, content: { marker in
                    Annotation(marker.title, coordinate: marker.coordinate, content: {
                        Image(systemName: "mappin.circle.fill")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(Color.red)
                    })
                })
                
                UserAnnotation()
            }
            
            //현재 위치 버튼
            MapUserLocationButton(scope: mapScope)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.clear)
                        .stroke(Color.red, style: .init(lineWidth: 2))
                })
                .offset(x: -10, y: -10)
        }
        .mapScope(mapScope)
    }
}

struct Marker: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
}

#Preview {
    MapView()
}

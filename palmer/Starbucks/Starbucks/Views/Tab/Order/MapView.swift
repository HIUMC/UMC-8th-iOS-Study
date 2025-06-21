//
//  MapView.swift
//  Starbucks
//
//  Created by 박정환 on 5/29/25.
//


import SwiftUI
import MapKit
import _MapKit_SwiftUI

struct MapView: View {
    @Bindable var viewModel: JSONParsingViewModel
    @Binding var hasDraggedMap: Bool

    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $viewModel.cameraPosition) {
                if let stores = viewModel.pinStores {
                    ForEach(stores, id: \.properties.Seq) { store in
                        let location = CLLocationCoordinate2D(
                            latitude: store.properties.Ycoordinate,
                            longitude: store.properties.Xcoordinate
                        )
                        Annotation(store.properties.Sotre_nm, coordinate: location) {
                            ZStack {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(.green02)
                                Image("Starbucks")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            }
                        }
                    }
                    UserAnnotation(anchor: .center)
                }
            }
            .onMapCameraChange { context in
                viewModel.visibleRegion = context.region
                hasDraggedMap = true
            }

            if hasDraggedMap {
                Button(action: {
                    print("버튼 클릭")
                    viewModel.calculateDistanceFromRegionCenter()
                    hasDraggedMap = false
                }) {
                    Text("이 지역 검색")
                        .font(.pretendardMedium(13))
                        .foregroundStyle(.gray06)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .frame(width: 88, height: 36)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                        )
                }
                .offset(y: 25)
            }
        }
    }
}

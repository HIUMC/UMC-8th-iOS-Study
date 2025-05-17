//
//  MapTopSegmentView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/4/25.
//

import SwiftUI
import MapKit

struct MapTopSegmentView: View {
    
    @Environment(\.dismiss) var dismiss
        @State private var selectedTab = 0
        @Namespace private var underlineAnimation
        
    @State private var cameraPosition = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        )

        

    var body: some View {
            ZStack(alignment: .top) {
                
                if selectedTab == 0 {
                    Map(position: $cameraPosition) {
                        UserAnnotation()
                    }
                            .ignoresSafeArea()
                    
                } else {
                    VStack {
                        Spacer()
                        Text("길찾기 기능은 추후 제공 예정입니다.")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                }

                // 상단 UI
                VStack(spacing: 0) {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.mainTextBold24)
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))

                    HStack {
                        SegmentTab(title: "매장 찾기", index: 0, selected: $selectedTab, namespace: underlineAnimation)
                        SegmentTab(title: "길찾기", index: 1, selected: $selectedTab, namespace: underlineAnimation)
                    }
                    .padding(.horizontal)
                    .padding(.top, 4)
                    .background(Color.white.opacity(0.9))
                }
            }
        }
    struct SegmentTab: View {
        let title: String
        let index: Int
        @Binding var selected: Int
        var namespace: Namespace.ID

        var body: some View {
            Button {
                withAnimation(.easeInOut) {
                    selected = index
                }
            } label: {
                VStack(spacing: 4) {
                    Text(title)
                        .foregroundColor(.black)
                        .font(.mainTextSemiBold24)

                    if selected == index {
                        Capsule()
                            .fill(Color.brown)
                            .frame(height: 5)
                            .matchedGeometryEffect(id: "underline", in: namespace)
                    } else {
                        Capsule()
                            .fill(Color.clear)
                            .frame(height: 5)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }

}

#Preview {
    MapTopSegmentView()
}
